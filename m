Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABB63A607
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Nov 2022 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiK1KXo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Nov 2022 05:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiK1KXn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Nov 2022 05:23:43 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E014097;
        Mon, 28 Nov 2022 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669631023; x=1701167023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8avruGnCnmAG8dlmi3XsuFaMDscuL2b3mrBVDQHAKSI=;
  b=ZyMPdoq6isbm20tbg13NIh+oOxlEHlA5gbQJELDjRY2cOhB4fUllCyg+
   VdlKi3jVoqoHJ0IokVGrkXxmesWhPUoVGk7gM0E/oEub2/UyN11dQfyhF
   XtHhXTunUNth1LB+0HHwG1OpnVubcc7NjURX8BamBSWg82O8GAzHcFgdd
   Co7DSO436oWbPdDS8lC4TGSXaZfHgLqdLqH9nTtIJfeOCRQr4wwcSKxhN
   LsZov0N2LPSzLAt1EgGiQlniada3su3/MeUJrZlyUkFrtCRfr4TriVQZ1
   zEM+Px+4HlqVZonwAv5/VrGsMjF86GQr02DfIlJD0Om24W6wW228fEonu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="70971363"
X-IronPort-AV: E=Sophos;i="5.96,200,1665414000"; 
   d="scan'208";a="70971363"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 19:23:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Et7dWHmgkVfxoWpEvqeqrJbSD+jVkfbJwRsAbZFz8LyKLlWc7wJN+2jq8bTuIWx4Fr8TIa6epgHTJLbTySVFvZS8gkD/pIXnE6ozDT3u+ASZpMaucO44U2hsNOyMNb7maOcgVRMsUSqa4ZI/qedg/FRjNlnnUuj7RUnKESe2DIp5yxFBx8aLnpB+grmQP9WQ3jQkThY9T9mhrb3mDDF6UNoptp1xIOd0c8yapC0HofJNc72JjxTBLTk0TeCcQztPLjtezAf5nQt0hj/+2cufGjP5fk4b34hB/3gRD57DXJdbzgGzzKZbl7s4/Ajat8iLXNLTe7qz15S6UfSxTnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8avruGnCnmAG8dlmi3XsuFaMDscuL2b3mrBVDQHAKSI=;
 b=TTYeQ62im/5sKrb4nklJPkRCFD4/OGBDu8762IkAXX5PwoJIFfQZXZdzlQ3HFL77PHmhdcX2BA3Jmb6B5AOq27j1P/vOOY2DmHHqPDO3QIsmdzE2Y/ZzZaGLketC3XxKZH6UTYNA3vLyYUe3WJr499aCyDfo4PVVHNnAsC8j2vvjDypR62Q+FQdkM3dCI4ChRNdClwfSnup2+tf0he1ySFnHMt+QO6L2r+9WEVF4crAURm6D95owUSwaQ6DpJghLvapGzwc9e46zp1LPEvIXeVxEM+CzxqtKYY3i+Wm5snlf54aGlKhts0tM4tGQZ//o1KlyJxyOTQX8cvt+Krp2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB7730.jpnprd01.prod.outlook.com
 (2603:1096:604:17b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 10:23:33 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%9]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 10:23:33 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Topic: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Thread-Index: AQHY+ZRI1TH8j3pp4UKX3oA91Nseoa5LEO4AgAD/qYCAAlPMgIAAkfOAgADHiACABHXlAA==
Date:   Mon, 28 Nov 2022 10:23:33 +0000
Message-ID: <3c84d3ca-88f9-0995-4c0a-2b5dc69670b6@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com> <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
 <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
 <Y4DOPjDKM64ryuP3@nvidia.com>
In-Reply-To: <Y4DOPjDKM64ryuP3@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB7730:EE_
x-ms-office365-filtering-correlation-id: 636b242a-aa7e-4c48-020e-08dad12a9a8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CjXHvSG2RMkkTjPQkHsQOT39dgZ3pr7aIUFCL9Q+hSTEPxo7MNCb+rum1pu4pWa/nF7TxFdO9eebY7fifKtH/w8D6g1CV9cNLMcQCjjECNRyi8W++ygsBzQEaGNaBtBdeGAXtYCiAewfgKGi+y515W7ra1sU3KUMPEYeIJqhVUnU4UscnDQzLqfsKKUYhnVzQz/J18DLlOtgDdrTfkUV92LbQgnK0Bij/2wR29GXK5buyCgOUu3/IWHDgWyIONL5koczWYkxv9THqFn9n6RLP1RFmTDrNCyvU7/hZP+2NMRMGtqjb8S82veVAjs0PHfvbGtwCo95BLTkVLb77Z2isZIFgelwpkY7LbXw+C8dO23nisUjNEXLUGD6XhpLuwYtQlZ6Q6SntAWLxUFkYsDgAaeL8IHBE7KdUWdq+wCe6lCe0VWotxmxFncwjIgHZHnLvz10ipQojMbo3V8iqVluDmON8vRQ3NwoxsQJnecAbpKclxlUi7x0t1h0/Gx+ZNKUDyqXn5wNXS84Yz3hipzKIKKPXiwFqUj9j7qUGwhaDyxqRj/BXC1x43OVQ5I52IY609+Kd/GZfN7dgBaL2WRlnDpDS4PCpMqPeRNhQ4tMUvffkQLpSFyP5i4trHQS+CpStOyFqjO6iXfIkz7m1OBZnKwPPwVuRKMQv5p961g/c4vVhLrxoQLF233N0lDH+mCrenSMKYyxjuLYMXDNvB2HcsE6qjm5j2+ZfHKZUp0D2OK/jC3kk8wGnSprZn4NVmJ0T2O8wRhq+V9j5sidaZHYWmk6KbdwZXMSsMVrrdFZikc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(1590799012)(1580799009)(86362001)(85182001)(36756003)(31696002)(91956017)(38100700002)(8936002)(2616005)(7416002)(122000001)(2906002)(186003)(83380400001)(82960400001)(38070700005)(8676002)(6916009)(66556008)(54906003)(316002)(5660300002)(31686004)(478600001)(53546011)(6486002)(76116006)(66446008)(64756008)(41300700001)(66946007)(6512007)(71200400001)(6506007)(4326008)(26005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVdhdFNaNjJMdEFsbk9obVVMV2V0MkpIQnZla0dyY3lwWWJMTmRXSEVWaDdD?=
 =?utf-8?B?eVJCMWE4dXo4NTNpb3hWcmFTRlV3YW9QSE5URWtKRmxQcDBPQnZYK3pjOXVO?=
 =?utf-8?B?MThkVS9SSkhNUmdyL3JOL1k4R3hrMml1NW9YQnBZN3JpNDFpandhMjUzRUJ6?=
 =?utf-8?B?U00vdnRlZzBBUHVqRWswLzRENTJpdWtGeVdDd28vUmF4aVNoZDBONHozRmZL?=
 =?utf-8?B?c1UydGhWN2g5bGJZMExrN1lCRlNnZENmeXlDZzRpVE5lYTNJU3hET2dRRUs4?=
 =?utf-8?B?b3FHeTVnUFFnbHZONndZQ0NlUkV6ek5ZZW4xN0ZyL21DWmZYZndveXVOQjc3?=
 =?utf-8?B?eDhWcXlPc0lQVTQ1dG9mY01BbkNRcHpXRE1TamgvbG5ld05XSXNQY2xtNFUz?=
 =?utf-8?B?Nkd0Mm02Uldmd3J5SWlUekdkWi9UWVhKZW9oMysxSXo2UG9DRG56NTN3eVd5?=
 =?utf-8?B?R1AvSkUzTGR6S09Za09oMWVpYTFpdnNkbW90Vm5CeGpSenBkRHpydW9JZUpI?=
 =?utf-8?B?LzZIMjAxaEFxUklnZndnTXNsb3l0RjRCakFhQTZNdndNRWpuM09PR3p6Vmw0?=
 =?utf-8?B?VTYrNXFuQ2ovQnhoclVnbEhSTDl3WHZrWEM0a0RJUDM4MWgyTUx3VHY4djRp?=
 =?utf-8?B?enhHSFBhU0dMSGhndkNXTnM5RzdKekhtaGIydGIyNXo0azE2NjBBWlA0RjZx?=
 =?utf-8?B?WmVKUDhMOURObWQ2K1oyMkg0NHNuQnExYUZ2SHdmMWRLU0J3R3pvaUdHSFQr?=
 =?utf-8?B?ek0zVlFTZGRJTkROaWVQM3dEV3NyS28wTjlMV2xvcXhscnZpSHBxUGpOQlhv?=
 =?utf-8?B?cjNJMlVDUjR1V3lXeGVPelc4YUQxemFsY1h1UUEzSGExZjJMZk1ELzNUTUF1?=
 =?utf-8?B?NFR6dHNyZW1zMEw5cjVUekMyK2x6djdtRVY0VVVpSnhveDdxWUNONUwreCt0?=
 =?utf-8?B?T0RtMkJDb3NOUXlveHJ6WDRsZ2ZMVXg5WXhVWnpVemtmRnBMUjdYUm84TUp2?=
 =?utf-8?B?WXVEeW1td0h2SG42VDQvazVFY1ZBakJuTy9ZcU9ZQ1g3TG95d1kxdlpPRDIx?=
 =?utf-8?B?M3JkZDJMcGV0Rm0zT0lSZXRqdFdLRFpDS0FlWEdFZURHOFNQSnBsRnBQTW1s?=
 =?utf-8?B?Q2h4dzhabGVzd3dDWnpPdGxyOVJNUDZPb1RKNU1yR0FRS2lrVTR4WWh3SkRT?=
 =?utf-8?B?eDE0dHNHYkxXc25kTEFJdW8yYmcxQmdRdm5aM2lDTG4zdTFpQm9iWmlXczBM?=
 =?utf-8?B?SWk4S2VJNTJnZVNwYWxLK0I1L2wxYW5jRXR6MmgzYU1OaHhnNnI0S2laQ2Rt?=
 =?utf-8?B?RlhXUm9zMFMvbXBud3o0MGZhb3ZwdEx4VGl2b1NYRTVhYUpMbDhHM25EVGVW?=
 =?utf-8?B?QklZVDFiVjg1azBpMjJFTnpXL0xXV3VnY1RGTmJ4S1dJQzF1djhYOHV3S1lL?=
 =?utf-8?B?MXVkcFFseHRvbkpKV0Mxc3F6ZHd3TGRGNm1Cckdlcy94NjZ5M3JNQmdzQ2NQ?=
 =?utf-8?B?ZVhrODNIWk9vMmhYSnBmMW4rVTJvNE9UN0FnbDdHSmV2S3Jsb3VlM3BQSk12?=
 =?utf-8?B?aisyOThGUVU3aHpuZlhlTlBzQ1pOeS80bFN5RHlZSnN3TlhUa0t4czJvbmxC?=
 =?utf-8?B?MFVSZlV2NTVrb3hxa1NwSlR3bHdmNE4xMExxT1kwRG0vZTdnRGg0QlVVbTU3?=
 =?utf-8?B?UDRGVXRKN01jbFl1bmpiMU92aVJ3UHM3cUdSai9tOHFQQyszc2gxVnNNMWhJ?=
 =?utf-8?B?a2xQbHc4RUNYWk9seml0NG4rM3pVY1NFWG1xNm9hRlJKSWRiRWRES0tiU05U?=
 =?utf-8?B?UFA4WTRFQUFNZFN1aTFPOVNJQmxJaGtwejRUNU9wMmJEWmtJVTlxTUMvNmpi?=
 =?utf-8?B?V0ZlNSt5SkpqTm9OSFgvY00wbnY1WTBsbGZvZmh4WlA0c1NyTHZyNGJOeW9v?=
 =?utf-8?B?NEtCaE04RmNxY1A3ODF5L2JSL3RNWHB1cG13TjhuRURtU1NkYkhkS0F1YnF6?=
 =?utf-8?B?dGJBRmJidTdyeVlIYXk1N3BERXl1Q2hrVmRvQVg4R1laQjBBcS9Kb1RrN1RR?=
 =?utf-8?B?VWxqbFBkQkp3SjFOU0xwcFZRTTJ5MHJrMlpodi9PWS9BbEhPWjVVKzlrL1A3?=
 =?utf-8?B?c25CS0FlNHh5TnJCQU5USUtQU055TzBFelpKUnhENFZRYXZvRExtZk1UQ2c1?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19E7A04168072041B73AB8497A0443AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUNKaU9aRXRGVS8wejR6RGV3T1VHcVd2OERLckJZV2FmbFhhaEdnZWZQVDBE?=
 =?utf-8?B?YzdKV2FKb25KU1E2U3hEcmxsZHdQOXRmdmRQaHliT1VvcE55bzg4cURtMDVS?=
 =?utf-8?B?S3NzbkdjUm5TZGtmUEg4OXIydzJRNDkzdTR5K1VoR0FWL2pvL0FjQ3VGZ1k4?=
 =?utf-8?B?YzJPWFV0WUFEcGwwbzZNZVRaZ01MVjhaL1NERG00QWxzOC83ZGprR1NJYzZB?=
 =?utf-8?B?ZktZK3ExL1duVVhXMGZLYm9aekdSN0dBVU5iQmZ1TE1FY3EvWnlRd1ViWFB2?=
 =?utf-8?B?S0RjQU0wbjdTc3IrWkhMU2hMcUhyeXRDVVlhaG9HSGVicks4c0lxMGNWM1gv?=
 =?utf-8?B?N3pua2pZTW1ITDY1MXBGcjkrMmJWdDRBK1l3WWQwdE0yWDN2L3lJR2NWbERn?=
 =?utf-8?B?YWc5RnhieGZTOW0ycnRoTi9Xa1BYWjdDemlJVk5WNW5QSnJtbXZ5NXg1MFVN?=
 =?utf-8?B?aFVqVXBaY3JtVXZRZlFlRHY3WTluREZnMlEyVlJSRUFxMmhoVXZHWUlPWW5U?=
 =?utf-8?B?NmZ1b0lRQnVybDhmSzlzVHVneUU4cW50N2ZMWUFZZmRMSGk3UDFENS9wSzln?=
 =?utf-8?B?VVRXRXlUNHNxRkk5Umo3eWhDQ2Fob203UUZ5NmFCNmZoYks0VjNWVkl5Y2s3?=
 =?utf-8?B?THVCWDR4Yk5GMGUwOTBOS25yam9JT3gvOGo1TFh2UzRNSmYwQkptMCtEQ0Jz?=
 =?utf-8?B?VGxFY3JOaWF1cmRqWmlwRmNpczZ4ekY1QzFYMzE3Q3BrU3o0R0RQZXVFNWlD?=
 =?utf-8?B?U1ZaY0JPZnZPU3oxRDNBOTNkMmNNRUVKRG5BdkpOWEpLVzJCd29UWVBuSzh2?=
 =?utf-8?B?cnV5QXN5MUJrOXVmSXYxS1hPUFZRYW40M09pRkE3dFNvU0Vad1lwSU9jTUxC?=
 =?utf-8?B?c1JoUUJBSVFVcjFPU0R2K1Ntc1JKWHpPcG1zQStIZXhGS0dhVTR4ZnhzWm5R?=
 =?utf-8?B?NW5rbzNIYTU5Y2p4SW8reWF4NmtNeFEwV3VKTGRrUm4xbHVhY0E1RWdHaGU1?=
 =?utf-8?B?NU55bXJFNzFZVjlyelFZY09pKzhkNTZzdWFPNFpGNkFJMUVra3EwMjlxZXNo?=
 =?utf-8?B?a2RhOWJoQTNVblRYOXlIMGtmTEdQYWtKdTZOb3BXWmV6Mm44WkduaFVOZVZM?=
 =?utf-8?B?ZDVtWmFFNmdnZFd5d0V3VkVGU2xOYzZCMlNqSHVvb3hmMUIyNndtcnIvY1ZX?=
 =?utf-8?B?cmxHb1YzSkl3bksxczhld2lqUTRUMXBIMFBSdTdhV1h4eGM5UWdjdEt3Z2JJ?=
 =?utf-8?B?NVBhUW15dExiUGI0cWwxZVRERWxYQm12bkpqb1I2SGlLSXROQ1Y0UVJCUUxQ?=
 =?utf-8?B?TFEwbytYMXdjV0R2QnA3WkdEWWlKNkNGNTMzMDNtR2ZwUGExY0U5OW9tdlJK?=
 =?utf-8?Q?qr8KHrttqwaOqWOwWXhNx1gCfH0jfn0M=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636b242a-aa7e-4c48-020e-08dad12a9a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 10:23:33.7510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wsQad+j7QOfkqoSONBCQ7Ie8M7vViCdxKtlfexo8xGBkW5tZXW9wy5+AAQDqPal3NOKKbMYP+L/8liiVQekow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7730
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI1LzExLzIwMjIgMjI6MTYsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+Pj4+PiAt
LS0NCj4+Pj4+PiAgICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYyB8IDMgKystDQo+Pj4+
Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4+Pj4+IGluZGV4IDFmOTkzOGEyYzQ3NS4u
NTg4MzdhYWM5ODBiIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L2NtLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jDQo+Pj4+Pj4g
QEAgLTQwOTYsNyArNDA5Niw4IEBAIHN0YXRpYyBpbnQgY21faW5pdF9xcF9pbml0X2F0dHIoc3Ry
dWN0IGNtX2lkX3ByaXZhdGUgKmNtX2lkX3ByaXYsDQo+Pj4+Pj4gICAgIAkJcXBfYXR0ci0+cXBf
YWNjZXNzX2ZsYWdzID0gSUJfQUNDRVNTX1JFTU9URV9XUklURTsNCj4+Pj4+PiAgICAgCQlpZiAo
Y21faWRfcHJpdi0+cmVzcG9uZGVyX3Jlc291cmNlcykNCj4+Pj4+PiAgICAgCQkJcXBfYXR0ci0+
cXBfYWNjZXNzX2ZsYWdzIHw9IElCX0FDQ0VTU19SRU1PVEVfUkVBRCB8DQo+Pj4+Pj4gLQkJCQkJ
CSAgICBJQl9BQ0NFU1NfUkVNT1RFX0FUT01JQzsNCj4+Pj4+PiArCQkJCQkJICAgIElCX0FDQ0VT
U19SRU1PVEVfQVRPTUlDIHwNCj4+Pj4+PiArCQkJCQkJICAgIElCX0FDQ0VTU19GTFVTSEFCTEU7
DQo+Pj4+PiBXaGF0IGlzIHRoZSBwb2ludCBvZiB0aGlzPyBOb3RoaW5nIGNoZWNrcyBJQl9BQ0NF
U1NfRkxVU0hBQkxFID8NCg0KPj4gSSdtIGZpbmUgdG8gZXhwYW5kIGl0IGluIG5leHQgdmVyc2lv
bi4NCj4gT0lDLCB0aGF0IGlzIHdoeSBpdCBlc2NhcGVkIGdyZXANCj4gDQo+IEJ1dCB0aGlzIGlz
IGJhY2sgdG8gbXkgb3JpZ2luYWwgcXVlc3Rpb24gLSB3aHkgaXMgaXQgT0sgdG8gZG8gdGhpcw0K
PiBoZXJlIGluIENNQT8gU2hvdWxkbid0IHRoaXMgY2F1c2Ugb3RoZXIgZHJpdmVycyB0byByZWZ1
c2UgdG8gY3JlYXRlDQo+IHRoZSBRUCBiZWNhdXNlIHRoZXkgZG9uJ3Qgc3VwcG9ydCB0aGUgZmxh
Zz8NCj4gDQoNCkphc29uLA0KDQpNeSBmbHVzaCBleGFtcGxlIGdvdCB3cm9uZyBzaW5jZSBWNSB3
aGVyZSByZXNwb25kZXIgc2lkZSBkb2VzIA0KcXBfYWNjZXNzX2ZsYWdzIGNoZWNrLiBzbyBpIGFk
ZGVkIHRoaXMgcGF0Y2guDQoNCkkgYWxzbyBhZ3JlZWQgaXQncyBhIGdvb2QgaWRlYSB0aGF0IHdl
IHNob3VsZCBvbmx5IGFkZCB0aGlzIGZsdXNoIGZsYWcgDQp0byB0aGUgc3VwcG9ydGVkIGRyaXZl
cnMuIEJ1dCBpIGhhdmVuJ3QgZmlndXJlZCBvdXQgaG93IHRvIGFjaGlldmUgaXQgaW4gDQpjdXJy
ZW50IFJETUEuDQoNCkFmdGVyIG1vcmUgZGlnZ2luZyBpbnRvIHJkbWEtY29yZSwgaSBmb3VuZCB0
aGF0IHRoaXMgZmxhZyBjYW4gYmUgYWxzbyANCnNldCBmcm9tIHVzZXNwYWNlIGJ5IGNhbGxpbmcg
aWJ2X21vZGlmeV9xcCgpLg0KRm9yIHNlcnZlciBzaWRlKHJlc3BvbmRlciksIGlidl9tb2RpZnlf
cXAoKSBtdXN0IGJlIGNhbGxlZCBhZnRlciANCnJkbWFfYWNjZXB0KCkuIHJkbWFfYWNjZXB0KCkg
aW5zaWRlIHdpbGwgbW9kaWZ5IHFwX2FjY2Vzc19mbGFncyANCmFnYWluKHJkbWFfZ2V0X3JlcXVl
c3QgaXMgdGhlIGZpcnN0IHBsYWNlIHRvIG1vZGlmeSBxcF9hY2Nlc3NfZmxhZ3MpLg0KDQpCYWNr
IHRvIHRoZSBvcmlnaW5hbCBxdWVzdGlvbiwgSUlVQywgY3VycmVudCByZG1hLWNvcmUgaGF2ZSBu
byBBUEkgdG8gDQpzZXQgcXBfYWNjZXNzX2ZsYWdzIGR1cmluZyBxcCBjcmVhdGluZy4NCg0KRkxV
U0ggb3BlcmF0aW9uIGluIHJlc3BvbmRlciBzaWRlIHdpbGwgY2hlY2sgYm90aCBtci0+YWNjZXNz
X2ZsYWdzIGFuZCANCnFwX2FjY2Vzc19mbGFncy4gU28gdW5zdXBwb3J0ZWQgZGV2aWNlL2RyaXZl
ciBhcmUgbm90IGFibGUgdG8gZG8gZmx1c2ggDQphdCBhbGwgdGhvdWdoIHFwX2FjY2Vzc19mbGFn
cyBhcHBseSB0byBhbGwgZHJpdmVycy4NCg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCihnZGIpIGJ0DQojMCAgX19pYnZfbW9kaWZ5X3FwXzFfMSAocXA9MHg0
MGZiZjAsIGF0dHI9MHg3ZmZmZmZmZmQ5MjAsIGF0dHJfbWFzaz01NykNCiAgICAgYXQgL2hvbWUv
bGl6aGlqaWFuL3JkbWEtY29yZS9saWJpYnZlcmJzL3ZlcmJzLmM6NzE1DQojMSAgMHgwMDAwN2Zm
ZmY3ZmFhMWRiIGluIHVjbWFfaW5pdF9jb25uX3FwIChpZF9wcml2PTB4NDBmNmQwLCBxcD0weDQw
ZmJmMCkNCiAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3JkbWEtY29yZS9saWJyZG1hY20vY21hLmM6
MTM4MA0KIzIgIDB4MDAwMDdmZmZmN2ZhYWRhMiBpbiByZG1hX2NyZWF0ZV9xcF9leCAoaWQ9MHg0
MGY2ZDAsIA0KYXR0cj0weDdmZmZmZmZmZGEzMCkNCiAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3Jk
bWEtY29yZS9saWJyZG1hY20vY21hLmM6MTY3Ng0KIzMgIDB4MDAwMDdmZmZmN2ZhYWU5NCBpbiBy
ZG1hX2NyZWF0ZV9xcCAoaWQ9MHg0MGY2ZDAsIHBkPTB4NDA3NzEwLCANCnFwX2luaXRfYXR0cj0w
eDdmZmZmZmZmZGFlMCkNCiAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3JkbWEtY29yZS9saWJyZG1h
Y20vY21hLmM6MTcwMg0KIzQgIDB4MDAwMDdmZmZmN2ZhYjVkMyBpbiByZG1hX2dldF9yZXF1ZXN0
IChsaXN0ZW49MHg0MGVkZTAsIGlkPTB4NDA1MWE4IA0KPGlkPikNCiAgICAgYXQgL2hvbWUvbGl6
aGlqaWFuL3JkbWEtY29yZS9saWJyZG1hY20vY21hLmM6MTg4Mw0KIzUgIDB4MDAwMDAwMDAwMDQw
MWFmOSBpbiBydW4gKCkgYXQgDQovaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJkbWFjbS9l
eGFtcGxlcy9yZG1hX2ZsdXNoX3NlcnZlci5jOjkxDQojNiAgMHgwMDAwMDAwMDAwNDAyMWVhIGlu
IG1haW4gKGFyZ2M9NywgYXJndj0weDdmZmZmZmZmZTIyOCkNCiAgICAgYXQgL2hvbWUvbGl6aGlq
aWFuL3JkbWEtY29yZS9saWJyZG1hY20vZXhhbXBsZXMvcmRtYV9mbHVzaF9zZXJ2ZXIuYzoyODIN
Cg0KKGdkYikgYnQNCiMwICBfX2lidl9tb2RpZnlfcXBfMV8xIChxcD0weDQwZmJmMCwgYXR0cj0w
eDdmZmZmZmZmZDkzMCwgDQphdHRyX21hc2s9MTIxNjg5NykNCiAgICAgYXQgL2hvbWUvbGl6aGlq
aWFuL3JkbWEtY29yZS9saWJpYnZlcmJzL3ZlcmJzLmM6NzE1DQojMSAgMHgwMDAwN2ZmZmY3ZmE5
ZjE2IGluIHVjbWFfbW9kaWZ5X3FwX3J0ciAoaWQ9MHg0MGY2ZDAsIHJlc3BfcmVzPTEyOCANCidc
MjAwJykNCiAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3JkbWEtY29yZS9saWJyZG1hY20vY21hLmM6
MTMwNA0KIzIgIDB4MDAwMDdmZmZmN2ZhYjgwYSBpbiByZG1hX2FjY2VwdCAoaWQ9MHg0MGY2ZDAs
IGNvbm5fcGFyYW09MHgwKQ0KICAgICBhdCAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJk
bWFjbS9jbWEuYzoxOTMyDQojMyAgMHgwMDAwMDAwMDAwNDAxYzhhIGluIHJ1biAoKSBhdCANCi9o
b21lL2xpemhpamlhbi9yZG1hLWNvcmUvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfZmx1c2hfc2Vy
dmVyLmM6MTMyDQojNCAgMHgwMDAwMDAwMDAwNDAyMWVhIGluIG1haW4gKGFyZ2M9NywgYXJndj0w
eDdmZmZmZmZmZTIyOCkNCiAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3JkbWEtY29yZS9saWJyZG1h
Y20vZXhhbXBsZXMvcmRtYV9mbHVzaF9zZXJ2ZXIuYzoyODINCg0KDQo+IEphc29uDQo+IA==
