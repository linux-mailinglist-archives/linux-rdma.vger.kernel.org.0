Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC164265E
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Dec 2022 11:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiLEKI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Dec 2022 05:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiLEKI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Dec 2022 05:08:27 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0E183A6
        for <linux-rdma@vger.kernel.org>; Mon,  5 Dec 2022 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1670234907; x=1701770907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CZjrXnFN6ht5k9YQaZSC6yN7DdBzP2duHBt7NG6zIyk=;
  b=oVUrlxxbHubnxHjx6m3TNwcnofdvhrMYGU8puTX9XMCjJ1+Ef6maOKUL
   VTEY8Rkl4ve0mVhRH6AkuCzKA0LnQiol4LfmT6NxK8gKbdz9cYkU7/6TN
   EALbmxMRe8bCL9+BNHNnGkxj4RX3IdKcFXWip+W9xo4fvkwxefgo48+vR
   LhlvaFLs8Ru6r6/kzLo2+r2z2vKR/4TgE8+CBscPqMM3eweTRWdRxpAkb
   VGRBjW73atn+qkMCAc9xiyBylWtc/iH37pm/sLnUpsiTrlaG4Ly8CcEvX
   ht0wqwkk8v2FtVWO8Sn2u+5nWJpZ71cl/fx5phpL6k7UlLrV5npWvPnBd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="73593272"
X-IronPort-AV: E=Sophos;i="5.96,219,1665414000"; 
   d="scan'208";a="73593272"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 19:07:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzvEkFRWsMPqOXL1bVzJSORzNuG9gKUNKCbznyN2GXxc0X45A215wHCipURuU6DdoXzsud1fqhUpzygSAtXajnATuoV/tNI63Pt2W0sbaxytCPqcZmQFrgrLrQKPXxIk4A0zUK3OctG4NcVkZrsi1BkyYdOGv2sq9GSncDcJB7u0X5GlffHV7gOlfoVm7jEwxuKC7H+woSaCpGQLbFA0CX3NzW+Qqa2OtZJz+mFISGEm1wes4Ejz0/RCoeaBjJ41RkznbMhnwM325LiE0NiZZ9eRKOmopa6kUrzTYH0cGfIKCf1gOSaXMkwgUAXIdRtJFL6aW4wdvDdilWd8zbglFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZjrXnFN6ht5k9YQaZSC6yN7DdBzP2duHBt7NG6zIyk=;
 b=ICR3Mn52MTf/RXQK0XvUJcElUxp96iNBTdYeZ3DWahz1rETJk9qHDaQ4rDywmLCFaij+EsxbQ26+2TfNzO0aCf3mn02+MjgiWeXF9vU/Q2+FE5C1bfDcB1k/gNFSykT/LKUnW6Iti4vpOrtWMmQ5Ozzw7IIt4YWXueaCI0IgEMlTmp8aBeRBC8r1ecKXp2D0DQH95IBOAr4pvQMpY0ipwnJlrOvzuvg6FabZDkCKL5t0PwHe5+XpA9Ela07cWj8d2goxp3uryWtWEOy97PZHlvmUsY4Ep+KbyW6ougX6mOcv+lsv32sRycY7Jh9mRYFH9f3iWr6GAFBAMNKKFUdPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYWPR01MB10275.jpnprd01.prod.outlook.com
 (2603:1096:400:1d5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 10:07:11 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 10:07:11 +0000
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
Thread-Index: AQHY+ZRI1TH8j3pp4UKX3oA91Nseoa5LEO4AgAD/qYCAAlPMgIAAkfOAgADHiACABHXlAIAK+8CA
Date:   Mon, 5 Dec 2022 10:07:11 +0000
Message-ID: <3d2b0f6d-6214-8d04-8356-852c34563501@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com> <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
 <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
 <Y4DOPjDKM64ryuP3@nvidia.com>
 <3c84d3ca-88f9-0995-4c0a-2b5dc69670b6@fujitsu.com>
In-Reply-To: <3c84d3ca-88f9-0995-4c0a-2b5dc69670b6@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYWPR01MB10275:EE_
x-ms-office365-filtering-correlation-id: b5c0db60-ce3f-4a6c-00f7-08dad6a879ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Sbe8uULe/KSNLeNZVFM5XDaxhC7I4ch+0kQ77NZY/nDBbycIbCgcNTuQWQ/WBzUongSu96WL96MYhgdtgOtVRT/EqS11Y0O9psD4g7aIfm0hKVS9M3cK76i5YMlUWoKlf5rbkXFGA8hRDqskqnFstf1GyQV8BCiCPSOddVDYQfFQM2i7Ey2tYJAFto/gDKzJXuOObdOva7vgvZBQ4hVRsOW2QXOGdQD6YwoC7EblirUEYloyIqgPMOzRRRkZ1Uo/GXRMXPGsm8tWaHYyhuHextkkzomZ7htb+W709ZM8SndJLTRlvkm7pFu8XXogPHrMsi6Cea5Rcr/ACmoi1S+X/7EqgsKd0Be0XR7D1pFHhrgWoaVE+cBO80MNcUt7KynKkX6QgBJgb5zBJKOpuTLZcVxrtF6L96y6ic2OQQ0RqXBFm6t7b03/DwwO20l/+FXNxSWvodNdQcO7vaaiUCBv4Ab9eZd+5dtnZhTO74/m+UmfPR4YlxVbaUIWrmTtsa6zDlc+NJK8MlD7Lhp+NfeGxGMhVyApfvyHPVdau0R3qTPbQWzg+UCv2hjxPHUhjoR1lgJwncDF7hVG05PaVUnQcMU3wt4PC8IUpzPv8rP6KGr2Pk/R+GC+pfPZq5sH1EtbRfNJYnR7jtpNFDlqpcz/2+SG233pqARu6m0qlq2NdXQVeAC3Addbrsj3D5oT/iYyza5TWNc3eO22Swrql6+mEQDgnaXC2DB2vz6innujG/sX68VSxxoin0yexOqwXxoAlWF4+55PK6nXw4NXhNCTRI3RvbXpziJwr+5XrA/n6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(1590799012)(451199015)(85182001)(36756003)(1580799009)(31686004)(38070700005)(31696002)(86362001)(4326008)(66446008)(2906002)(66946007)(76116006)(8936002)(41300700001)(91956017)(8676002)(66556008)(66476007)(64756008)(7416002)(122000001)(83380400001)(38100700002)(478600001)(2616005)(6916009)(316002)(54906003)(6486002)(82960400001)(5660300002)(71200400001)(186003)(53546011)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHc4d1dIdmt4c3JIUytyejFDR2M5NU9WeWJicks4aTNIQXN4S2VaUkZlTnpU?=
 =?utf-8?B?Zm53OWo3YlpNcWF3Q2xYK2xCTVlkZGRvaUJFRlRWUUVFQW9UaktWM3ZTRjI5?=
 =?utf-8?B?bkVOSkd5R1BZU0VRTVhDczRLWUdqVDZoMU5EeEJtbkFJaWpudjNEOEF2bUhv?=
 =?utf-8?B?SVR5eHo2ZjhSMHR3S3ZiQlJKUndBa2MyeHlrN3hMOGxiNmZPbWw1dHlrUnZV?=
 =?utf-8?B?eFpxSXJDeERNVHF2SmdEdjF0TzFsZVJneHVMZTIxOFAxdC9XSjBmVGlVcFFz?=
 =?utf-8?B?b2JzVEM4QkNrN2FUYko0N1YwamROR2FFeDBKM1lteXZpTnNtaHVmZnoyQ0tw?=
 =?utf-8?B?N2RPb0treFg2eUUrZ0xBQ3JzZ1orQUtNNW4ra09qZG5ib2dueG9yOWpIOXRl?=
 =?utf-8?B?KzdLT0Z4Smlod2FzSGFUeVh1R3IwdEwrN2NUUU15WE1EOG9RcWdmb2xHSjdv?=
 =?utf-8?B?M1czcXhHYSt3cnJEMWpFN3B6cjJyaW9EQmgyL1JpNklqU3ZrajZ0c0pEMWx0?=
 =?utf-8?B?dDU2d0VSK0VUckZ1QzNYejMwL1ZNcDZNcGF6NHFQbm13R2F1dms2dHdSMW9v?=
 =?utf-8?B?R2ZqZnE4eHhVSnBLOEVWdk0rWkhzYUpmM1FRNHNwY3dqVzZNQ0Q2M0JjU3l3?=
 =?utf-8?B?K3RGWm1RVnBVNDliSnA1MlJjRmVtN3Z1cG1tRUFKdi9kRlFkeURaNk1pRzI3?=
 =?utf-8?B?ZHhFV3BhRGh0N3F0QVQ1ZCtYSlZkK1RiaXZDSnF6TUlJdVRmdnVvcEQ0Wi9R?=
 =?utf-8?B?SnVQcHZhdWNDRVgxK1BNenhlcU9MaUN6ZC9TdlkwcytlME1KaHdKbmQ4VjhP?=
 =?utf-8?B?aC84a1BJTjAyNkxabXZNSnBJQ013aFdZTEpYK3A4NjAxOXZmZjFHQzBUZWNU?=
 =?utf-8?B?UkJZOFZmbEUrRmlXbk9qRFJZcjVlSGpLRjRmVHFyL3JnbStXVGIzVlV3cTZQ?=
 =?utf-8?B?a1hDYWplRWs0TVRmSmg3TE5iNncyTXZCSGNOdHBCem05a0N2SitxTXMvUUtk?=
 =?utf-8?B?OFdpaHdsTDZHckNhcGVFWGxVdWZvaG9mSm1hZEVteHFRdThkaWZ0T1pabFhV?=
 =?utf-8?B?TDRyd3BicDR4L25OVk9ac0hCbW1Xb3VnSzV3M0kxQVRKRWdkd3JXTHFORjBu?=
 =?utf-8?B?cFN2cUZFQ05MUWpkN2Q0aDh1RVBXRUpTNTNaV2ViZkkyTHBmZmNRNU1ic2Fm?=
 =?utf-8?B?TGVvRCtvODB1SkZFZVpRTm1Ocm9VdERVT21BOVJEcWxRM2ZnSlBCZ0duYjRS?=
 =?utf-8?B?ZXFyTlFvVFBUaDZKSEQ1b0xsRDdaNnh6V0RqdDhUZERxaXorNDMvRTRNalZT?=
 =?utf-8?B?YWZNclFqU0NiM0lrNklhOHhZRkJVWitIQTJWSEtBdFFoTG90ZGw2NWdaQVpJ?=
 =?utf-8?B?RVI2MEY3dHg3U3VrdEh0NUlLQXNFNGxpcGdxeUgrRUc1TVAyWHBWaFdvM3ZU?=
 =?utf-8?B?WXdqUzlSNjQ5NkNPZ3NhVys3KzNXcW4wRmhIenYrSmhwTHBhS1dTaXR0cTRo?=
 =?utf-8?B?ODREdERBTzRyRTY2S2thSWRqQjNSTVE0b2hKTytLeEo2Tm9adzlmNStEazN4?=
 =?utf-8?B?MXg0ZmQ3eGtJdXRpSUNUNHB6U3ZOY3VXZTV5V2w5NGtaMldMQlF6dkJhWlFr?=
 =?utf-8?B?blp3YnhhamY3MTViV0d6dEpJYm1PZXoyL3NubG1XbkZ2YmdjS3VqT09MM09Y?=
 =?utf-8?B?WUpWOSt1aS9KaG42OUdSQ2E5SGFPVzNZd2dNWXhvclR6Y0UzZ0VOcGl1d2tH?=
 =?utf-8?B?UUE0dVRHN2xycC8wRGVCbHdZZi9sRVFmV1Q1WVdzdzZ2WTVwTWZ2bXk3LzlK?=
 =?utf-8?B?bklQL2ZGSHZhTGxTeXFXbzJZc09ibWhDbHRNcmVWWlZKUHpiL1MzVjBnVDk2?=
 =?utf-8?B?dFE0TnVGRnhhVWVzcUhRVE1jWU54RFZ5dVUwYnl0QnNTUWtEUjFkTDJmT3hR?=
 =?utf-8?B?eVVIdUI0Mm1Ia3V5K2l0ZDNabmtjZVFlblZLNWF0V0hGSXVuWTIrNlhoeTJr?=
 =?utf-8?B?WEF2SzVCdStjeVloWGdJSGlZaFNxZ3Rja0p5UWZTRzRZcm1WeDhuNnIxSzF6?=
 =?utf-8?B?VlVCRzhTd09GYUI5TEo2Y3QxOGZPRWUyM2JwRDlveERiZTBmM1k0S3d2L1FE?=
 =?utf-8?B?clAwUVhZb2lFQlF5aU1XWlloMytkQmJPRWYwUXhoTFBUcVNXN2dZL1NFa3gw?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63740EB4E0828D4FA2405AACB6195C8E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OVJyNWwrcEQyZGlRYXZacTk3Uld6ZFdJZGh0OGFZdi9LQjNaM0NaNEhTTmZX?=
 =?utf-8?B?NG1XZ3dVTE1qNUI1SmhKQTlUZ3kzQkdtZmtWVEl1akkwTjJXQlpjY3R2YWNy?=
 =?utf-8?B?K3N4THZsRit0dkwvWDYxejAzbFJFMW9pNXJ1N0d4bU5YZ1dZZVpJWnJTcXlu?=
 =?utf-8?B?TEg0VVZsQ1llaFhXcUV5ZFlNdkhacklSelpQak1YU21Rc2xyMjFnRG9udGNJ?=
 =?utf-8?B?R1lQT29QeVVVeTRDb0xnMUtoN24yR1h6dDNkYzlRMHJGVDh4UEViTmlZYXU3?=
 =?utf-8?B?RjhFeXU2WnRZbmxmdmp1eXViYXFyOC9IUW1sa3RFOFZYUXdIK2lXQ1JjUmNG?=
 =?utf-8?B?WXp1bEVtNnFzY3VjUTRIWTdRc1FTRGlPSU9sM2s4eVBOV1pVM0ZyTk8xNFpU?=
 =?utf-8?B?QW16OGdrOU8yRjJmVTdzY1NMQW5Gc2xWb29VVm1jalh3QVhwbTJ3M1c1bjBO?=
 =?utf-8?B?WUVPOU80dDdVV2lQZG5VOE10NXN0TndZaFFyd04veVkxMjhCUFdlalhYMHNp?=
 =?utf-8?B?RG5KQXBUK1RabWw3eGNudS8yMllsRDIrZlQ2cW85bE9EK0lNTkxqSGdjOFRN?=
 =?utf-8?B?cFNjdXVaOUF0VEFDR2VBRzN5eHNBVUt2NXpWYjk1YnI2YVV5V2gyUEhaWFNW?=
 =?utf-8?B?ekJHYUp4RWxOaHVEakNyZiszblZGaElnWk1qMTVtclRBWkd1bjlNYnhOdldN?=
 =?utf-8?B?a1RGUllxaFpYWG8vUStHTWcxOURycGVGR0JZTG1OWkQyam5ZSDNhUnZqYTJG?=
 =?utf-8?B?QmRTWlI0VjhidDd6T2tXaWhGcXg4VER5RzluUG9oMjFIeEgyZ2NYRDE0SnJI?=
 =?utf-8?B?K053UHZVWlpDMFQrdDhkSms1RmdOWXUva2tFbEJ4cXdJRDhDTkc3ZjQrakJY?=
 =?utf-8?B?NkxhZE9sdTlJdmJKYU1SZnNJSXhIaHQxdnVmRnFiNnA5b3JZaURPUFVRazk1?=
 =?utf-8?B?T0RMeTlMYmNscmFrRWN4aWlFUnhGTzNYZFNHd3ROZFl1V2VKZHpNb0t0dnNz?=
 =?utf-8?B?Y2FxRlJIM1VrdWR2bFFTK09SbG1mMmZPNUlYa0JiSWdCZ2lXcERmOWp1QndV?=
 =?utf-8?B?UGF0N05OZXNoYmg4RCtsaUdUYkVtcFk1MW5qK2NTVkpjUVd0eFpsZEExWG9V?=
 =?utf-8?B?MFhUMDUvZDMrd1hCOUFybmNjN3VzbUJ2WXJPSjhRaUd2S05URDgyTTduY2kr?=
 =?utf-8?B?RjRmdEgyWHliTjQ4SXF1SXhnQnFKeW9zMUtOTWxJSTk1ZndIc2JmelczdTgv?=
 =?utf-8?B?Y1J3ems0MUtRZm5NTU1ZejdtTVVod1VCN0ttTktIVmh3MTRHdkREK0RpN0x6?=
 =?utf-8?B?WWxVTnd2eW9wV3E3M0tjTytUcUpxaE5FZjdDeGEzOElPRkNHS1VCNHVacHRW?=
 =?utf-8?Q?fch/1Y7jhQ/95YRx6btoUkioUtgKn2Cc=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c0db60-ce3f-4a6c-00f7-08dad6a879ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 10:07:11.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSB706BpZg53r0HaA8skIScfIVeQjFIKui8r0UA7Mq8dZuzWSXmtgIgIVsj88xzdM6DWVUVsP0ibA6GKXnLi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10275
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmFzb24NCg0KQ291bGQgeW91IHRha2UgYSBsb29rIGF0IHRoaXMgdXBkYXRlOg0KLSBNYWtlIFFQ
IEZMVVNIQUJMRSBmb3Igc3VwcG9ydGVkIGRldmljZSBvbmx5DQotIGFkZCBtb3JlIGV4cGxhbmF0
aW9uDQoNCmNvbW1pdCAxYTk1Zjk0MTI1YjU5MTgzZDVmYzY0M2E5MTdlMGEyZTdiYjA3OTgxDQpB
dXRob3I6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCkRhdGU6ICAgTW9uIFNl
cCAyNiAxNzo1MzowNiAyMDIyICswODAwDQoNCiAgICAgUkRNQS9jbTogTWFrZSBRUCBGTFVTSEFC
TEUgZm9yIHN1cHBvcnRlZCBkZXZpY2UNCiAgICAgDQogICAgIFNpbWlsYXIgdG8gUkRNQSBhbmQg
QXRvbWljIHFwIGF0dHJpYnV0ZXMgZW5hYmxlZCBieSBkZWZhdWx0IGluIENNLCBlbmFibGUNCiAg
ICAgRkxVU0ggYXR0cmlidXRlIGZvciBzdXBwb3J0ZWQgZGV2aWNlLiBUaGF0IG1ha2VzIGFwcGxp
Y2F0aW9ucyB0aGF0IGFyZQ0KICAgICBidWlsdCB3aXRoIHJkbWFfY3JlYXRlX2VwLCByZG1hX2Fj
Y2VwdCBBUElzIGhhdmUgRkxVU0ggcXAgYXR0cmlidXRlDQogICAgIG5hdGl2ZWx5IHNvIHRoYXQg
dXNlciBpcyBhYmxlIHRvIHJlcXVlc3QgRkxVU0ggb3BlcmF0aW9uIHNpbXBsZXIuDQogICAgIA0K
ICAgICBOb3RlIHRoYXQsIGEgRkxVU0ggb3BlcmF0aW9uIHJlcXVpcmVzIEZMVVNIIGFyZSBzdXBw
b3J0ZWQgYnkgYm90aA0KICAgICBkZXZpY2UoSENBKSBhbmQgbWVtb3J5IHJlZ2lvbihNUikgYW5k
IFFQIGF0IHRoZSBzYW1lIHRpbWUsIHNvIGl0J3Mgc2FmZQ0KICAgICB0byBlbmFibGUgRkxVU0gg
cXAgYXR0cmlidXRlIGJ5IGRlZmF1bHQgaGVyZS4NCiAgICAgDQogICAgIEZMVVNIIGF0dHJpYnV0
ZSBjYW4gYmUgZGlzYWJsZSBieSBtb2RpZnlfcXAoKSBpbnRlcmZhY2UuDQogICAgIA0KICAgICBT
aWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQogICAgIC0t
LQ0KICAgICBWNjogZW5hYmxlIGZsdXNoIGZvciBzdXBwb3J0ZWQgZGV2aWNlIG9ubHkgI0phc29u
DQogICAgIFY1OiBuZXcgcGF0Y2gsIGluc3BpcmVkIGJ5IEJvYg0KICAgICBTaWduZWQtb2ZmLWJ5
OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0K
aW5kZXggMWY5OTM4YTJjNDc1Li42MDNjMGFlY2MzNjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lu
ZmluaWJhbmQvY29yZS9jbS5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jDQpA
QCAtNDA5NCw5ICs0MDk0LDE4IEBAIHN0YXRpYyBpbnQgY21faW5pdF9xcF9pbml0X2F0dHIoc3Ry
dWN0IGNtX2lkX3ByaXZhdGUgKmNtX2lkX3ByaXYsDQogICAgICAgICAgICAgICAgICpxcF9hdHRy
X21hc2sgPSBJQl9RUF9TVEFURSB8IElCX1FQX0FDQ0VTU19GTEFHUyB8DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJQl9RUF9QS0VZX0lOREVYIHwgSUJfUVBfUE9SVDsNCiAgICAg
ICAgICAgICAgICAgcXBfYXR0ci0+cXBfYWNjZXNzX2ZsYWdzID0gSUJfQUNDRVNTX1JFTU9URV9X
UklURTsNCi0gICAgICAgICAgICAgICBpZiAoY21faWRfcHJpdi0+cmVzcG9uZGVyX3Jlc291cmNl
cykNCisgICAgICAgICAgICAgICBpZiAoY21faWRfcHJpdi0+cmVzcG9uZGVyX3Jlc291cmNlcykg
ew0KKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGliX2RldmljZSAqaWJfZGV2ID0gY21f
aWRfcHJpdi0+aWQuZGV2aWNlOw0KKyAgICAgICAgICAgICAgICAgICAgICAgdTY0IHN1cHBvcnRf
Zmx1c2ggPSBpYl9kZXYtPmF0dHJzLmRldmljZV9jYXBfZmxhZ3MgJg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAoSUJfREVWSUNFX0ZMVVNIX0dMT0JBTCB8IElCX0RFVklDRV9GTFVTSF9QRVJT
SVNURU5UKTsNCisgICAgICAgICAgICAgICAgICAgICAgIHUzMiBmbHVzaGFibGUgPSBzdXBwb3J0
X2ZsdXNoID8NCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoSUJfQUND
RVNTX0ZMVVNIX0dMT0JBTCB8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIElCX0FDQ0VTU19GTFVTSF9QRVJTSVNURU5UKSA6IDA7DQorDQogICAgICAgICAgICAgICAg
ICAgICAgICAgcXBfYXR0ci0+cXBfYWNjZXNzX2ZsYWdzIHw9IElCX0FDQ0VTU19SRU1PVEVfUkVB
RCB8DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
SUJfQUNDRVNTX1JFTU9URV9BVE9NSUM7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSUJfQUNDRVNTX1JFTU9URV9BVE9NSUMgfA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsdXNoYWJsZTsNCisg
ICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgIHFwX2F0dHItPnBrZXlfaW5kZXggPSBj
bV9pZF9wcml2LT5hdi5wa2V5X2luZGV4Ow0KICAgICAgICAgICAgICAgICBpZiAoY21faWRfcHJp
di0+YXYucG9ydCkNCiAgICAgICAgICAgICAgICAgICAgICAgICBxcF9hdHRyLT5wb3J0X251bSA9
IGNtX2lkX3ByaXYtPmF2LnBvcnQtPnBvcnRfbnVtOw0KDQpUaGFua3MNClpoaWppYW4NCg0KDQpP
biAyOC8xMS8yMDIyIDE4OjIzLCBsaXpoaWppYW5AZnVqaXRzdS5jb20gd3JvdGU6DQo+IA0KPiAN
Cj4gT24gMjUvMTEvMjAyMiAyMjoxNiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+Pj4+PiAt
LS0NCj4+Pj4+Pj4gICAgICBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIHwgMyArKy0NCj4+
Pj4+Pj4gICAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9j
bS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYw0KPj4+Pj4+PiBpbmRleCAxZjk5Mzhh
MmM0NzUuLjU4ODM3YWFjOTgwYiAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvY20uYw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5j
DQo+Pj4+Pj4+IEBAIC00MDk2LDcgKzQwOTYsOCBAQCBzdGF0aWMgaW50IGNtX2luaXRfcXBfaW5p
dF9hdHRyKHN0cnVjdCBjbV9pZF9wcml2YXRlICpjbV9pZF9wcml2LA0KPj4+Pj4+PiAgICAgIAkJ
cXBfYXR0ci0+cXBfYWNjZXNzX2ZsYWdzID0gSUJfQUNDRVNTX1JFTU9URV9XUklURTsNCj4+Pj4+
Pj4gICAgICAJCWlmIChjbV9pZF9wcml2LT5yZXNwb25kZXJfcmVzb3VyY2VzKQ0KPj4+Pj4+PiAg
ICAgIAkJCXFwX2F0dHItPnFwX2FjY2Vzc19mbGFncyB8PSBJQl9BQ0NFU1NfUkVNT1RFX1JFQUQg
fA0KPj4+Pj4+PiAtCQkJCQkJICAgIElCX0FDQ0VTU19SRU1PVEVfQVRPTUlDOw0KPj4+Pj4+PiAr
CQkJCQkJICAgIElCX0FDQ0VTU19SRU1PVEVfQVRPTUlDIHwNCj4+Pj4+Pj4gKwkJCQkJCSAgICBJ
Ql9BQ0NFU1NfRkxVU0hBQkxFOw0KPj4+Pj4+IFdoYXQgaXMgdGhlIHBvaW50IG9mIHRoaXM/IE5v
dGhpbmcgY2hlY2tzIElCX0FDQ0VTU19GTFVTSEFCTEUgPw0KPiANCj4+PiBJJ20gZmluZSB0byBl
eHBhbmQgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KPj4gT0lDLCB0aGF0IGlzIHdoeSBpdCBlc2NhcGVk
IGdyZXANCj4+DQo+PiBCdXQgdGhpcyBpcyBiYWNrIHRvIG15IG9yaWdpbmFsIHF1ZXN0aW9uIC0g
d2h5IGlzIGl0IE9LIHRvIGRvIHRoaXMNCj4+IGhlcmUgaW4gQ01BPyBTaG91bGRuJ3QgdGhpcyBj
YXVzZSBvdGhlciBkcml2ZXJzIHRvIHJlZnVzZSB0byBjcmVhdGUNCj4+IHRoZSBRUCBiZWNhdXNl
IHRoZXkgZG9uJ3Qgc3VwcG9ydCB0aGUgZmxhZz8NCj4+DQo+IA0KPiBKYXNvbiwNCj4gDQo+IE15
IGZsdXNoIGV4YW1wbGUgZ290IHdyb25nIHNpbmNlIFY1IHdoZXJlIHJlc3BvbmRlciBzaWRlIGRv
ZXMNCj4gcXBfYWNjZXNzX2ZsYWdzIGNoZWNrLiBzbyBpIGFkZGVkIHRoaXMgcGF0Y2guDQo+IA0K
PiBJIGFsc28gYWdyZWVkIGl0J3MgYSBnb29kIGlkZWEgdGhhdCB3ZSBzaG91bGQgb25seSBhZGQg
dGhpcyBmbHVzaCBmbGFnDQo+IHRvIHRoZSBzdXBwb3J0ZWQgZHJpdmVycy4gQnV0IGkgaGF2ZW4n
dCBmaWd1cmVkIG91dCBob3cgdG8gYWNoaWV2ZSBpdCBpbg0KPiBjdXJyZW50IFJETUEuDQo+IA0K
PiBBZnRlciBtb3JlIGRpZ2dpbmcgaW50byByZG1hLWNvcmUsIGkgZm91bmQgdGhhdCB0aGlzIGZs
YWcgY2FuIGJlIGFsc28NCj4gc2V0IGZyb20gdXNlc3BhY2UgYnkgY2FsbGluZyBpYnZfbW9kaWZ5
X3FwKCkuDQo+IEZvciBzZXJ2ZXIgc2lkZShyZXNwb25kZXIpLCBpYnZfbW9kaWZ5X3FwKCkgbXVz
dCBiZSBjYWxsZWQgYWZ0ZXINCj4gcmRtYV9hY2NlcHQoKS4gcmRtYV9hY2NlcHQoKSBpbnNpZGUg
d2lsbCBtb2RpZnkgcXBfYWNjZXNzX2ZsYWdzDQo+IGFnYWluKHJkbWFfZ2V0X3JlcXVlc3QgaXMg
dGhlIGZpcnN0IHBsYWNlIHRvIG1vZGlmeSBxcF9hY2Nlc3NfZmxhZ3MpLg0KPiANCj4gQmFjayB0
byB0aGUgb3JpZ2luYWwgcXVlc3Rpb24sIElJVUMsIGN1cnJlbnQgcmRtYS1jb3JlIGhhdmUgbm8g
QVBJIHRvDQo+IHNldCBxcF9hY2Nlc3NfZmxhZ3MgZHVyaW5nIHFwIGNyZWF0aW5nLg0KPiANCj4g
RkxVU0ggb3BlcmF0aW9uIGluIHJlc3BvbmRlciBzaWRlIHdpbGwgY2hlY2sgYm90aCBtci0+YWNj
ZXNzX2ZsYWdzIGFuZA0KPiBxcF9hY2Nlc3NfZmxhZ3MuIFNvIHVuc3VwcG9ydGVkIGRldmljZS9k
cml2ZXIgYXJlIG5vdCBhYmxlIHRvIGRvIGZsdXNoDQo+IGF0IGFsbCB0aG91Z2ggcXBfYWNjZXNz
X2ZsYWdzIGFwcGx5IHRvIGFsbCBkcml2ZXJzLg0KPiANCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAoZ2RiKSBidA0KPiAjMCAgX19pYnZfbW9kaWZ5
X3FwXzFfMSAocXA9MHg0MGZiZjAsIGF0dHI9MHg3ZmZmZmZmZmQ5MjAsIGF0dHJfbWFzaz01NykN
Cj4gICAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3JkbWEtY29yZS9saWJpYnZlcmJzL3ZlcmJzLmM6
NzE1DQo+ICMxICAweDAwMDA3ZmZmZjdmYWExZGIgaW4gdWNtYV9pbml0X2Nvbm5fcXAgKGlkX3By
aXY9MHg0MGY2ZDAsIHFwPTB4NDBmYmYwKQ0KPiAgICAgICBhdCAvaG9tZS9saXpoaWppYW4vcmRt
YS1jb3JlL2xpYnJkbWFjbS9jbWEuYzoxMzgwDQo+ICMyICAweDAwMDA3ZmZmZjdmYWFkYTIgaW4g
cmRtYV9jcmVhdGVfcXBfZXggKGlkPTB4NDBmNmQwLA0KPiBhdHRyPTB4N2ZmZmZmZmZkYTMwKQ0K
PiAgICAgICBhdCAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJkbWFjbS9jbWEuYzoxNjc2
DQo+ICMzICAweDAwMDA3ZmZmZjdmYWFlOTQgaW4gcmRtYV9jcmVhdGVfcXAgKGlkPTB4NDBmNmQw
LCBwZD0weDQwNzcxMCwNCj4gcXBfaW5pdF9hdHRyPTB4N2ZmZmZmZmZkYWUwKQ0KPiAgICAgICBh
dCAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJkbWFjbS9jbWEuYzoxNzAyDQo+ICM0ICAw
eDAwMDA3ZmZmZjdmYWI1ZDMgaW4gcmRtYV9nZXRfcmVxdWVzdCAobGlzdGVuPTB4NDBlZGUwLCBp
ZD0weDQwNTFhOA0KPiA8aWQ+KQ0KPiAgICAgICBhdCAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3Jl
L2xpYnJkbWFjbS9jbWEuYzoxODgzDQo+ICM1ICAweDAwMDAwMDAwMDA0MDFhZjkgaW4gcnVuICgp
IGF0DQo+IC9ob21lL2xpemhpamlhbi9yZG1hLWNvcmUvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFf
Zmx1c2hfc2VydmVyLmM6OTENCj4gIzYgIDB4MDAwMDAwMDAwMDQwMjFlYSBpbiBtYWluIChhcmdj
PTcsIGFyZ3Y9MHg3ZmZmZmZmZmUyMjgpDQo+ICAgICAgIGF0IC9ob21lL2xpemhpamlhbi9yZG1h
LWNvcmUvbGlicmRtYWNtL2V4YW1wbGVzL3JkbWFfZmx1c2hfc2VydmVyLmM6MjgyDQo+IA0KPiAo
Z2RiKSBidA0KPiAjMCAgX19pYnZfbW9kaWZ5X3FwXzFfMSAocXA9MHg0MGZiZjAsIGF0dHI9MHg3
ZmZmZmZmZmQ5MzAsDQo+IGF0dHJfbWFzaz0xMjE2ODk3KQ0KPiAgICAgICBhdCAvaG9tZS9saXpo
aWppYW4vcmRtYS1jb3JlL2xpYmlidmVyYnMvdmVyYnMuYzo3MTUNCj4gIzEgIDB4MDAwMDdmZmZm
N2ZhOWYxNiBpbiB1Y21hX21vZGlmeV9xcF9ydHIgKGlkPTB4NDBmNmQwLCByZXNwX3Jlcz0xMjgN
Cj4gJ1wyMDAnKQ0KPiAgICAgICBhdCAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJkbWFj
bS9jbWEuYzoxMzA0DQo+ICMyICAweDAwMDA3ZmZmZjdmYWI4MGEgaW4gcmRtYV9hY2NlcHQgKGlk
PTB4NDBmNmQwLCBjb25uX3BhcmFtPTB4MCkNCj4gICAgICAgYXQgL2hvbWUvbGl6aGlqaWFuL3Jk
bWEtY29yZS9saWJyZG1hY20vY21hLmM6MTkzMg0KPiAjMyAgMHgwMDAwMDAwMDAwNDAxYzhhIGlu
IHJ1biAoKSBhdA0KPiAvaG9tZS9saXpoaWppYW4vcmRtYS1jb3JlL2xpYnJkbWFjbS9leGFtcGxl
cy9yZG1hX2ZsdXNoX3NlcnZlci5jOjEzMg0KPiAjNCAgMHgwMDAwMDAwMDAwNDAyMWVhIGluIG1h
aW4gKGFyZ2M9NywgYXJndj0weDdmZmZmZmZmZTIyOCkNCj4gICAgICAgYXQgL2hvbWUvbGl6aGlq
aWFuL3JkbWEtY29yZS9saWJyZG1hY20vZXhhbXBsZXMvcmRtYV9mbHVzaF9zZXJ2ZXIuYzoyODIN
Cj4gDQo+IA0KPj4gSmFzb24=
