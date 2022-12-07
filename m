Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7677645119
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 02:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiLGB0I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 20:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLGB0H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 20:26:07 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51F5131A;
        Tue,  6 Dec 2022 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1670376364; x=1701912364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GwMEGEmrPzSvV4htnL5U/5gGd/3SH4xvwx9bJ7g7CfU=;
  b=UOByPAvNijX7wuevTEHQCntvv0l6d/P0vrQ8H8FoB186Q1tjzW+EYwdz
   uTtJOlxLVFeH2gY/82Tt4hEMyQeZmU5dNNWg4Nsv9oCnd68mCcldn3xiM
   xh0U9aK+fBH359KmT2K/PHXYsCu3I0sfJrhdGbiVgdavVcNz9bH9txuZ1
   8hruMGk+VJ7oYHi8rERAWeMzDtZ32C+Ay5vIEegaXAlvSCPP1Gj5KUP5m
   hymSradqntHC/u7gfs52VADkAUImDmzXDTrZY4eq+MJhVPT0lw2Lu4Llg
   WQdVbZcZsdOENrW3dBhs0lhAjwvNXxSRnq9nK3ttA3VbZqZ7OzxZ3lw8J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="72219840"
X-IronPort-AV: E=Sophos;i="5.96,223,1665414000"; 
   d="scan'208";a="72219840"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 10:25:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmbqLo32wvLEhakPPobFLYZL/fKFcV/uZ8NQmgjviUM3bO6L3gtkQpBTN6gwMittDISybYif4bS45PIhcB1XhreSi1DK61igZMTVi5demcw9FEdrjLimEUy0TI2Oc7Xg1qt46/izpplrBvzt4h/HSpMifzNl+uymhyP1pCksyvYFbQN8MTqJ3Dpus0GITFBKcIAT6nDtd9gvo35NNd0LuxKZydneI4w8R9e+6C3ggbj7wjt95Gmzq+SjPtcS3J48kcp+jnav2ZGt+mzIcfeV++BF989RZ73d0iD7XuAFrNoZyTJKthf1yre3lDRxLwihH33Y9NLMF8cClz0ItY4zbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwMEGEmrPzSvV4htnL5U/5gGd/3SH4xvwx9bJ7g7CfU=;
 b=AjOk2pxLAlqMBFcXe0QuHG0w7f5zMerJDuhNesqZWhliGFH5V0R0F58PUtFiQg0/9jfgaN+t8kwrnV7LZnD12k1iYppVMKrrLUIEztsWN8Rt7eGkK54QWpAQ4Ik4eyYBmAXzmoEVg5zrbyJ7LUl1GELio94Jy+m5pdfvVisuRy/rg7SDNvcCSP/P3fPI8Y5sIUwM4jc5EdNqRkVQJInu6ufEbRRhcGxsSCl32RNWBctXO/1SqzUCH0+DZOIfvcxroe5dvPEWY8485qdwiB0hvvZ0kcb2AGJPUAZ/Sa3H2SsYBz6JwGaQyORej9tcYN1EM5rHKFr3McRBGHTIYxni5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TY3PR01MB10092.jpnprd01.prod.outlook.com
 (2603:1096:400:1de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 01:25:56 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:25:56 +0000
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
Thread-Index: AQHY+ZRI1TH8j3pp4UKX3oA91Nseoa5LEO4AgAD/qYCAAlPMgIAAkfOAgADHiACABHXlAIAK+8CAgAB29YCAAhwMgA==
Date:   Wed, 7 Dec 2022 01:25:56 +0000
Message-ID: <a7fd6db0-32eb-d5c3-7596-2783b94df232@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com> <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
 <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
 <Y4DOPjDKM64ryuP3@nvidia.com>
 <3c84d3ca-88f9-0995-4c0a-2b5dc69670b6@fujitsu.com>
 <3d2b0f6d-6214-8d04-8356-852c34563501@fujitsu.com>
 <Y44ml2qsQkx+QNRs@nvidia.com>
In-Reply-To: <Y44ml2qsQkx+QNRs@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TY3PR01MB10092:EE_
x-ms-office365-filtering-correlation-id: 60a5dd9d-7c4b-41ee-6fe1-08dad7f1fd5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJOoT5I1sV1k4Agk+hp6kT9QnCAD1QVzqryCY1h7z4y1zGp50ehoyLLFlOBQAzta6/F+FRk9l9TlzR2QJ/qSZ0hB+oV1UAihV8xkHiazJfg2IN1MzGKhUQrRjCzjNcrqkcwGhZYrLbrNivVGAlBCrE7o+sIJUp3/tAxFYZaka3g802ibvut4+i05BXv2RjHk16C0UI8rfm4gtoHKLgx/VXP5P5/MgD1ak6WphDSPE+Rzsto3DoYmEQFXFOn3uly/ro+12bemNY48Nh8fWQAsIrsVk2xE6+57xxubGHdFa/draY5/mExhR/VclTy38MfZ309VY+f/Esh3uVZiD36+f/x7Ekq05AxoTVmGh4oaXQTpK4bETVv8+FZrRs0DPhDY+1gojRs4qM6ogcKnv62d8DdbHcRAPFXgWg9n5Ljh0/wgFMKysJEu9ymcWaMo05GZbebRjvSmgxE3Cv6De+GQ9Gzaen5xjiKkZ0nPBOwNM87hDfyZK4IEYNhnC2HONI51r0fqBegNk61//c/f4i+7fBadt1KelzawS8QNFuArI+QUbR7NzYpoujPV+QlYgP0i/K5DsyZdf0OK/vzjwd4t/Jn7pEU+TlGTc3iNijhU1/0dN40qLl2+CSKyP91BEQZkUFxGfcrfH/WlAEw1lW5CVY3X08Fs6w0s8IdGrJdVXg7jo2aE7cCExYNmGzYQ47/PLQGs45ugxlbl2DYE5W1xr3AWu/KaxsmnhvIK0Bwbwgtgk1cZ9tgi0yP0/f+v+UTqi3FLTAn8RB1AbEC7w/5q7aXFqFFpRdbc5AcfHJPi3SzkFAB5SSzsTx6WgmQRJESG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(1590799012)(451199015)(186003)(71200400001)(26005)(6506007)(53546011)(2616005)(1580799009)(83380400001)(6486002)(41300700001)(6916009)(38100700002)(122000001)(66556008)(66446008)(7416002)(76116006)(8676002)(64756008)(86362001)(66476007)(4326008)(82960400001)(966005)(316002)(54906003)(8936002)(5660300002)(478600001)(31686004)(66946007)(6512007)(91956017)(31696002)(2906002)(36756003)(85182001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dytFSDQ3TmdNWFI3TjlLZlVVaW8zTTZPbU5vLzVnbDdMZnQydVVEeVRjaXRU?=
 =?utf-8?B?b3RrdnFoUVI1TzBOK1lETXFFTHEraVN0NUx2RE5EQ29IcE1LWVFMZGM4ZUdn?=
 =?utf-8?B?VHhlaXlvcmRka2dteWRBeUVBam5SMXpzdnVCazcwQThqdWwwcXNPYWtiUWtP?=
 =?utf-8?B?aFNMZXdwTGFhODFFSnFCMDhYQlJLWUpqaUxjZGVXc3dyMnR0UERETmZQMEcv?=
 =?utf-8?B?WXp1TUVMeTNDa09KT3BVRzkwWW5kdHJma2lmSExsVDZRcnV6SnhSbk1laW90?=
 =?utf-8?B?bFZTeVFsVVM5OFJUeENsenJiTTlXMlR3b2ZUQzAwaUlKenU3b24yOXhPQmp0?=
 =?utf-8?B?ekN4MHBXV2RrVjRsTmVkZW1rbHpFYzdFa0wrQXBuYVVDZ2llSEg3V2F5Lzds?=
 =?utf-8?B?UndCblpjS2ZLSGtCY3hTYUw3TTQ5cHpnajA2ZzU5em14VVE2ZFQvU1BiTENz?=
 =?utf-8?B?QmFFTXpWSjRuZ2o5ME5EdDgxTFgwWmRKVUc2QWcvcHdSOTdnVitYc2poSXJE?=
 =?utf-8?B?Wkx1dGNCR1Y5WHU2ZDhidXpZUkJkYlR4RWxpM1FQQjJTYlE1WHBaSldNeFov?=
 =?utf-8?B?a3oxKzZTYjd2YWNkbUhwdWt4WmhXanlrVmdqYlBoZDJqRmNSYmw2REZyVGY5?=
 =?utf-8?B?Mzg5ZDVGZDg1OWhPQjN6VVdtTEFhRi9HUDJ6NkJRcmdQUS9PM1ZaSlIzczlu?=
 =?utf-8?B?YkJxVHZHaWFQNkM2bU45RmpURW43Uk9zdE1tODk1L0tpdVdMdllZWGdNYWZT?=
 =?utf-8?B?N1JpWWs1Ui8xMy9uMlBWWlpuZ1RKU0NlMkNodEE0QXFnMVlUTmhNZTk4WTJI?=
 =?utf-8?B?MDFKL1B3dEZkUmNMYXd4akRuL0RLb1JFTGVyRGNKQWpHV3N6TGJXcnNsRlNK?=
 =?utf-8?B?V0dHVFBFMFl4RUNWVzJNM1oyb3dvbXRZK2kwWUZHcFpQY1dHZ3UvUTI4cEVm?=
 =?utf-8?B?Q0tPdUpsbHIzU3o2NWZzOUplQ3R5TjdGMVJjeW8vZDRFZEQ0UkpKSUdwbmlL?=
 =?utf-8?B?VWFGUENrelJqcWptdUhHZDkxcXBQQ01qWkVyV0RVMldnTFA3YVNRck50V2I2?=
 =?utf-8?B?cTNwTW9SMSs2Z1pZRUxBSjM2ZDhHczFtUWFYTEVKNUlmVFFiSFVaSUsvc0Ny?=
 =?utf-8?B?TkZPbFgrVHBkdDRqMnhTQlZkTVVUVWpCSXE4dVliQzdsWS9GUHpXTlA4ZG5k?=
 =?utf-8?B?UkxnUWVSRUVnSUQzc0hhSWpmN0xJMXc2eTlqUkpoUlBLc1VyUnl0VnFRSXVM?=
 =?utf-8?B?eDBvTDE3OXUyNlVMV0ttRDhUcFRDNGgrdVRDUVFXS0dBWnNjTUFkY1o5OTBt?=
 =?utf-8?B?cFBEeG1mOU9EWlVSNGUyUjBGS2FnNitYMHhMbmpIeklTVkpuUzd4cWhCOTVU?=
 =?utf-8?B?SGpra3I2UCtKcjRtcmpPcGZta21NVDBmTkFmL0hPQ21NZFNhT1NaMFJKc0ZV?=
 =?utf-8?B?aGJ2V3VmbUlMQVN0bytGc1NLSGcrVkZhOGdNTjNjdFVDZmJkME43dDY3MEt6?=
 =?utf-8?B?TXM4Q2c5RDdpSlVnNTlVNkVHdjVjN2JBTVMxdGR0bVY5SW15OExxbG1sdU9n?=
 =?utf-8?B?MUdkb0dlS3lrd0FoQU1FUitIMm5aNmJQSmNoTWN6djdxSDBJUDY2Qm1sUlJy?=
 =?utf-8?B?aUhYVlg2eEdxSEhVNUpmWnVwTloyMUxrdEZOV2x4MENnYmdPako5NDZLYXRP?=
 =?utf-8?B?UEJ5T3U3VDlSN0N2YWxXbWNmR1F5VlRyUTU1QVlQa0Y0YVN2OUVnZHNHTlhR?=
 =?utf-8?B?emdTN2hlSjQ2MHo1WVF3K3BVVVVGOEhSbVl3WFJObXE1OHFCZ0FzZlhWWHI2?=
 =?utf-8?B?VDV0SEh2T1Vnd1dCc1BCa05pbWU1cCtmdFJ6dUlQaDI0Nm1pMHJ4U01FaGRr?=
 =?utf-8?B?MlNuamNYV1hqcldmUXVvTCtZTm95eHdwcHRSR3VDSm9IZmlBMmF5bGo1cEpU?=
 =?utf-8?B?cnh3NFBQUEwzdG9hakVyNTBUN1dPV0xHUllhbFZQUGQxYUNNaU1YMGFOZW80?=
 =?utf-8?B?bkpDR1dZeDlTUGY1eWQ0ZHV5Y3FGWGc5RHFoTlYxb0M3WFRqVUtheCs3djhU?=
 =?utf-8?B?NjRPcnJwbi9uaTB6TW0zVFRxcjdIUDFCYktTUjlrdHVKZExRM3B2Q1Z6SkJ4?=
 =?utf-8?B?Q243eEhkc3hobXNtbEV4MlBibW9FWERyTG05cVFUTlpPbithNStQM2ZxT1dy?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E23B7E6EF5304AA08D5D5B1B721114@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YlMrZ3dXU1doc25nRWRNUEdKMmh5VmpiSmlIejhSak9iTUhtMkJXejhQcXZ0?=
 =?utf-8?B?MThXRjdXYnVmK1dwSEREaGNEVm1LNkFLUHlNYTdCN2dhWnUvWmNjanhPV2JN?=
 =?utf-8?B?VWp2T1N6WldXRmp1VXNnVk9mbDRicEZhVjU5UG1udnBqemEzQWhMV0JPdHJm?=
 =?utf-8?B?Q3dSQldBbThaWmNSdkRxMm9FemFjOUlnUmxTa00vMGZ4WWN0V3l6M3QwbHl0?=
 =?utf-8?B?STM2UHY3a2h5MTdkSGFwQVY3Rjkzc1ZiVXM5Y2VCcy9TR0d1RG1PZ3ZLblow?=
 =?utf-8?B?bi9tRlFzaElOVXpVR1V1TjZ6dk9QT2tDdC9qOFdycDFob2IwWm15bWlpb2pM?=
 =?utf-8?B?YkwyVEVWNUVNZHZqSUVOZEgyUjMwRXVaSG8xOFl1bkE5N0lkRldmU3ljZW1X?=
 =?utf-8?B?NzNoUHh2cWtPR3BoQjlGUzlZTlE4MmhRTWdpYngrc2RydVFWbER0U2swczRk?=
 =?utf-8?B?bzR4L1EvTTdXYlc2UTQxOHZrSGppNEU1emYrWXJpVDBhTUljSHNQWHBRK2tE?=
 =?utf-8?B?SXVOTnNXSFhKMVp4eXlvWEpmUmFhVmxVeTBaWkI4eFRzcUN2OS81L0tQaTl4?=
 =?utf-8?B?Q2g4UTIyVFB1WVBzbmdGMkxPcGJwUEZ5RFFHWGxjTkFJREFRbVZ1RHdvd1dK?=
 =?utf-8?B?ckN3SWwyYzJtTWdwZHNIc25LdWJibE9kVWxtMHFPMjBIblZlNVRybDZ0bXFY?=
 =?utf-8?B?alF5SlZjWFpzQ2xyR3FnQ0RJRVh1bG1Da0VOdTBxc3dXRUJvTDVvYjFUYnNt?=
 =?utf-8?B?Wm81VTJzeGZOQ013M0RVZlVYWGx3em5EaFY4a3Q2SEhaNkpBajd1UGJMTGE5?=
 =?utf-8?B?Q2VPRmtNZDBmZ3pMeXV3UW1aYzBZUmtBYisySVdhSVhKMkE1MTB0c3QzZi9D?=
 =?utf-8?B?MHBWeVUwKzB6dGxvcjBmTGxwL3F1VkR1QzFhQ3dwTkdCaXZtaHdidkduMDkx?=
 =?utf-8?B?bW1abHBWNmx6cnh3WkVxNGo1a3UwSEwzTHZTQzlRYjM3Zyt5QTBSbUNjVFRS?=
 =?utf-8?B?NUR3dWUzTjNPRGdsM0RQWkl0cmVhRUJTYkUvUXFQZmpjSzNhZGVxOVhtTEpQ?=
 =?utf-8?B?WGRuNEJOcG9sVTdQVHp6bTY0L05JYkNRRStYeXQrLyt3Wko1ZjVvdUhSSVcy?=
 =?utf-8?B?SEdvbldGZ25XVDdGVjJlc0xGQ2tIemVhNWpPVkJ6V2xmclpDQ1JpdFU0Wm1a?=
 =?utf-8?B?T2YvZVBoUnpFZzNTRm9QQXYrRmsvcFo4T3BQdEdaZWR1elQ4LzRHZ1lPbDBP?=
 =?utf-8?B?ZkJsS2c3RUVXaTIzb0hzVTlGdXBHakJkTTZmbjF6ZmZQa05VdXh2eVIvRUJG?=
 =?utf-8?B?MGtlakc1WHcyMGFLZ3ZDRGpsdVlieWx1SDNpS01WQTF0L2VJWnFPbE5RMHBP?=
 =?utf-8?Q?zWoTBidmfKYKETvxwoFjuTutrJot1BDY=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a5dd9d-7c4b-41ee-6fe1-08dad7f1fd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 01:25:56.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HygKfKLy5O/DyIeHuUJkIKHcGiMgoEPXmJNtFaj8trYuJbGHzaocBUTqo4YCqHgnGfQEpV8yejgXyAA+dEbD8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10092
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ICANCg0KT24gMDYvMTIvMjAyMiAwMToxMiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBN
b24sIERlYyAwNSwgMjAyMiBhdCAxMDowNzoxMUFNICswMDAwLCBsaXpoaWppYW5AZnVqaXRzdS5j
b20gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+IGluZGV4IDFmOTkzOGEyYzQ3NS4uNjAz
YzBhZWNjMzYxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0K
Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4gQEAgLTQwOTQsOSArNDA5
NCwxOCBAQCBzdGF0aWMgaW50IGNtX2luaXRfcXBfaW5pdF9hdHRyKHN0cnVjdCBjbV9pZF9wcml2
YXRlICpjbV9pZF9wcml2LA0KPj4gICAgICAgICAgICAgICAgICAgKnFwX2F0dHJfbWFzayA9IElC
X1FQX1NUQVRFIHwgSUJfUVBfQUNDRVNTX0ZMQUdTIHwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBJQl9RUF9QS0VZX0lOREVYIHwgSUJfUVBfUE9SVDsNCj4+ICAgICAgICAg
ICAgICAgICAgIHFwX2F0dHItPnFwX2FjY2Vzc19mbGFncyA9IElCX0FDQ0VTU19SRU1PVEVfV1JJ
VEU7DQo+PiAtICAgICAgICAgICAgICAgaWYgKGNtX2lkX3ByaXYtPnJlc3BvbmRlcl9yZXNvdXJj
ZXMpDQo+PiArICAgICAgICAgICAgICAgaWYgKGNtX2lkX3ByaXYtPnJlc3BvbmRlcl9yZXNvdXJj
ZXMpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpYl9kZXZpY2UgKmliX2Rl
diA9IGNtX2lkX3ByaXYtPmlkLmRldmljZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHU2
NCBzdXBwb3J0X2ZsdXNoID0gaWJfZGV2LT5hdHRycy5kZXZpY2VfY2FwX2ZsYWdzICYNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgKElCX0RFVklDRV9GTFVTSF9HTE9CQUwgfCBJQl9ERVZJ
Q0VfRkxVU0hfUEVSU0lTVEVOVCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICB1MzIgZmx1
c2hhYmxlID0gc3VwcG9ydF9mbHVzaCA/DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKElCX0FDQ0VTU19GTFVTSF9HTE9CQUwgfA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJQl9BQ0NFU1NfRkxVU0hfUEVSU0lTVEVOVCkgOiAw
Ow0KPj4gKw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBxcF9hdHRyLT5xcF9hY2Nlc3Nf
ZmxhZ3MgfD0gSUJfQUNDRVNTX1JFTU9URV9SRUFEIHwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJQl9BQ0NFU1NfUkVNT1RFX0FUT01JQzsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJ
Ql9BQ0NFU1NfUkVNT1RFX0FUT01JQyB8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmx1c2hhYmxlOw0KPj4gKyAgICAgICAgICAgICAgIH0N
Cj4gDQo+IFRoaXMgbWFrZXMgbW9yZSBzZW5zZQ0KDQp0aGFua3MgZm9yIHlvdXIgaGVscCwgaSBo
YXZlIHBvc3RlZCBWNyByZXZpc2lvbi4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MjEyMDYxMzAyMDEuMzA5ODYtMS1saXpoaWppYW5AZnVqaXRzdS5jb20vVC8jdA0KDQpUaGFua3MN
ClpoaWppYW4NCg0KPiANCj4gSmFzb24=
