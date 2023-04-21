Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF996EA415
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDUGtm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 02:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDUGtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 02:49:41 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA45100;
        Thu, 20 Apr 2023 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682059779; x=1713595779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WOLiwGGiWHTAj4HkP/481OaAuWAUlV4k7yzLdzkK3/0=;
  b=V46sdNL1TPPd+MX82nSvaBp4sBlt+qcBfhttNh4A00DYDO/kRTjtgv5j
   YULHEko2NwMr/xbP8RMAuTTbrSp1RqXYhY7kjUoyVUxONyfGqiBmx8ZvW
   np3FsQODpcumGsDDoreiOkd5H/6g5q27MoZKAcjITvlxujSh83ayL3th8
   zuJutygOqfFpKD9TsY8W8lySQOhCL3n3NbmFo0ryV7VG4MgtJcU2Imysv
   ayPv5hXWyMYHU0UYlOt/W6SDRarBm3ZCWm9+sg+zJizcSyzihdNZhZT+C
   Zbbx7Rprtopwq2YRVvCECvcnX72VC40HXZX5FDXBruHjzoqizfZCyJ6E+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="82904215"
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="82904215"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 15:49:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxb3bqXt7QlEsQGoSzUDRl+zCqhv1Pf3AwUeZM83+ZSK5aag1osdbMMw8QKvOppAmwr/1VWGPG1hcR7DgiOaVXJx8dEAJpvDKYpfpxBPVhNq+JbbYpMcPig/GaJ5Ps5wiydUWslckMGcns+HIa2rB4uE3NFo6hH1Ztl2FDqWnnzwvFVwy4mw7VYvwgzFx07CaJymglNPMwh2/94iKFqQpvQRDp4J6rjtAbALXe83bz+FuJrYSV2yanhp22hMghFKJe4ftp4hii2leT/3Kr5yreOWkYmNV8a6i9G2wWa9iKCX+BZx1vMaU+8UR49SADjSfy/z2bZQsmicNlBoruKOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOLiwGGiWHTAj4HkP/481OaAuWAUlV4k7yzLdzkK3/0=;
 b=T3yedYJW5P6qyaQn4YhALSIkSd912XlAgS8JbdGb+QnpyUxpyq6y9BYThLV8NGBCJj2MMkCl/TacCg+TaeO0KhJbq0ypjW4vJyOu0QMqbfyZILq22iBwAbyfkeFrwTQZMbq0AZIswroXQa71vAmC8QZmFgRcxYaFWS1c9ybrlMhKj5+xwbz6XhruXnwh0LDG1cTnq+Qlz8iVMa4lSSZTiEQQuYjrnijRObE2YunURe+EV5gFReLwYoyMTC3IYxQyHdDNEa3oALO0FoLrVPV20j/vkP0NXfA1agqtN3jbKiLdMJaCcm+c9synzwhiqUPH41BSmMTDRju7SLY76OPnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYYPR01MB7806.jpnprd01.prod.outlook.com (2603:1096:400:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 06:49:32 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 06:49:32 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jinpu Wang <jinpu.wang@ionos.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAIAAouyAgADWyICAAfyLAIAACjEAgABXMwCAAb1lAIAD0eCAgAEIcgCAANmvgIAADtcAgAGyw4CAADnvAIAA1EaAgAGMJoCAAFb9AA==
Date:   Fri, 21 Apr 2023 06:49:31 +0000
Message-ID: <97a580be-5fe8-e17f-c6dd-a6b22952363e@fujitsu.com>
References: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
 <20230417180452.GG15386@unreal>
 <0985e0a9-fe19-1c07-0da7-48ec88eb77c6@fujitsu.com>
 <20230418075706.GB9740@unreal>
 <65860af3-7d48-5a26-f916-50450633a893@fujitsu.com>
 <CAMGffEkyNnSXDfwuzCQ_ERZ-53OnoJ7gOF4eL1MAPYc74V43iQ@mail.gmail.com>
 <51b9e74d-70e0-3d76-ade9-93d960074ef9@fujitsu.com>
 <00202749-1b0d-91c8-9a52-cf8a66d8d340@fujitsu.com>
In-Reply-To: <00202749-1b0d-91c8-9a52-cf8a66d8d340@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYYPR01MB7806:EE_
x-ms-office365-filtering-correlation-id: 1265f4e7-a701-4dc1-d460-08db42348fa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUm4LF3r0i2s/qm5K/2m6MdFVtm9ra47huYq4xOu4oc1XGm0ra+0WJvdPZaKz1CdI5rpGzLtIulTfOaykumlqPwdodXltzO5fnd4ZSQ7tdzwcdKdFIbIFOwk+0AlJzuNWTdxSz1qN9BZuhTI4lXaxQnT0aKflkuolXzz8MatxudK4HiXhwEH0XP54wS7PPOyyAmRFrv/o8lzOWVh6qj7/UHxyUvpm9hg1h8KUjj0Hpkob+RGl5CM+4cWyWBnPrLzmJDTAtp1730AZ1bk5wzQR2mRl9DStwpgjqSGrSHXK9A78ftrQMCLbnSfxmq4hiamiAOvJA2dBMTrqdZ1MP/Y59NIK3cQSjC6SLA8LFu3pY68zTca8CSHAAc3UA8tw+KrcP55sT7THXtRuduqRzexFiUdsVKdKAg0HSpzOyM4PuG41RDOeO4SW/rp5svwh/WpdEbd36fLiZ8d6sU/GSe89+8+iuFcUPZqiF88gQTHABRDRtJpPrJMJYOv0a4BfdpfTR84NLEHIM26v3oErdq+NxWqNn2uGTTiihJRBxekfmLDZI1PMG4Mebl8z4z9mjwf4Kz4S9qb8cVmS3/MWgfAoF0efmmsrgMyzUXyyBkof2z60oEVp48YjBfHvtUVHDkMF3QYVZCyPHrlh+tWx3gbPiAtiusX7hgkysUsHjUpEawoMn4P1Svk26z0BPBpzI4RyQra6EVBPQFePr7JRtHK3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(1590799018)(451199021)(54906003)(31686004)(83380400001)(478600001)(2616005)(6486002)(6506007)(26005)(6512007)(71200400001)(66476007)(66446008)(6916009)(4326008)(66946007)(91956017)(82960400001)(64756008)(66556008)(316002)(41300700001)(122000001)(53546011)(186003)(76116006)(66899021)(8676002)(85182001)(38100700002)(8936002)(5660300002)(36756003)(2906002)(38070700005)(86362001)(31696002)(1580799015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVczLzBiWUlkc2Jlb3hUY2phcklDdUtwL1NzVzRNN0d1clBzY1hqWVhSNWRy?=
 =?utf-8?B?cmtESkgxVjhFZExIV21XbEFvUzZrQmdKTHlRM1NIT1JIbDE5TWwrYTBFYmJD?=
 =?utf-8?B?bGc4Mi9wck52NW4xR0dwUWpWNWdGUThNWFBwZVZoQlE3LzlCL0IxVlpsUmZL?=
 =?utf-8?B?bFQ0VzBWMVp2eXlIaFRZdGNiU1ZOUTZxVUI2enBQUlB6L05nVTltZkhCUUJ6?=
 =?utf-8?B?emJNMHpkMUV2N0Vkc3picVlRR0R0bjZMK1ZDK1dJd0doejFqK21Xc0R0dlAx?=
 =?utf-8?B?SWhLWjQzdmZrR0FMckZOQi9JbHJRY09DdWJFV1E0RFh4alhiWU9pdEVvYjdv?=
 =?utf-8?B?L3A0YUZCdFY2SG1tNHY2ekg1eGtJWVh1ekNlMjA5YkduV1c0N1REQkZ4QXYy?=
 =?utf-8?B?U0xLTFFqcW9aVFZNbWNSVjBNMmo0RjJNaDVsOTVTbVZidUI5OWpMZTFmTmVZ?=
 =?utf-8?B?M0VkVGhRaUsxMkdzYlRTUFRyWmVEMjFVQU9GVThCSVAwZG5RcDdoTXd2NFV6?=
 =?utf-8?B?a2Mzdnc2dEp1WUxZZEYwVnBuRlplR2x2Q056VXUvU1NFbWVLSXhXamtaTGVW?=
 =?utf-8?B?Sm9HTGJKdzg1dFkyajVIdERFaVY5UzlzUFhlM2kwUmlPa2dWbnJpaEQ2M1pS?=
 =?utf-8?B?dkZaVlpVRWtRS3lEdTRTSm9yU0MzRVpnelBYZTk3REZqQmRoY2dwTmhCRWh0?=
 =?utf-8?B?ekJZekZtUGE4emZtVmxMRis5Rlo3OFJWSnJ2ZThzUTJ1R1J1ZWdVd2NDYVB5?=
 =?utf-8?B?cXRxZ2RGVFZKU0R1ZG9RaVk1Z2pSTG9vWE5vOGVidThoY0c3RzJhb2puek5O?=
 =?utf-8?B?NTRodmpjYTJucEJBSUJ1Vy8xcUJESVByRk55UEk0WnhrSlBuaXRYb0ZqM3lI?=
 =?utf-8?B?cWZVbjJyTE5hT1FnV0tKWFh1Q0VTcmN0QjhjaDVxOGp4S3k4UER3ZGgwWWVL?=
 =?utf-8?B?WmFGVi9CMkd6Z3pHWnJsVnZQOXlYa2pLNWJoZHFxSWdETVBpcnJxL1FxYWlD?=
 =?utf-8?B?Qk0vdDVMUDQ0Sjl1S3JjVHMyOWNmZlRJci9kcGhGUTF1dkx5Z2dIV1NjSHRn?=
 =?utf-8?B?MCtSbzA3blcvVHZDZ3kwdmU4b1VxSm4wMWI2SUVWOXhaRFFJL3hjb2VwQlF1?=
 =?utf-8?B?Tkx1TysvSU1NS001YUkrSWdsVDVsNFJuNG5CWFdDM3lKbDJwWmNpNnBya2VY?=
 =?utf-8?B?Z1gyMEVYSlNiaGs1emUwaytXa0pHMFIwSXpTTmgrWjRjdStMV2VTVDNtRE9B?=
 =?utf-8?B?aWhBWlkvUmpQaE1pd0lSdGZKcmFkTEY5NXVFdG5oczNVY3dQQnpSV2NtWFFC?=
 =?utf-8?B?TEYyM3czZWdZdmNFbFBLbkx0TmlhdTNxOEZyZnpydjQ2VFNvdVE3VllMZnJN?=
 =?utf-8?B?NG9CSmJ0c0RTeEZlMzcwMUE2OHpMbXVHaGdVN0NVakZrZkl1WkcyRy82WW5Q?=
 =?utf-8?B?a0U5ZDZncWxCdTh1aVhGOXNMMWdyUmI1NlpEMXRrNWh5Y2lLKzJIQ0czRGdE?=
 =?utf-8?B?MmlpRHFVMXN4dWxWUnlHZGNaWnkzVHZ4MmdnM0h0U1FBRWE2UWRQdlpHTk1p?=
 =?utf-8?B?d0Fma2t5WkQ2WStqTnY0b0xKTXBDS2JraTZDU0pWeUFVaGVBcENpMy9Kdjl4?=
 =?utf-8?B?VUhNeW42a0dCTGl0NytReFErajRWeFFvTzhoeGNtR2g2WkNhUjBKL1VENkpR?=
 =?utf-8?B?OGVsNzRRNVRXUlFFRm9BcVk2dlFqejBMLzNFMitVZkxFRThFc3NucEEwQU9z?=
 =?utf-8?B?Q0JFTDNuZjRuZjdGQXBGWEY1YzEweEd4SmVPQzV3T1RvbHBlVlRDVWxXSzhy?=
 =?utf-8?B?ZkV0Smt6STZxMDg4eDE3djA1allXQzh2K0pDNlFiTHdvSE43OUtPNXZ4ZjJJ?=
 =?utf-8?B?YWpEaCtwUm9uYVYxTWZYbWxrVm83VkNScWpYV3dreXAxTWxqdEliVDlQM0Na?=
 =?utf-8?B?UXVoRm9QVHU1VW1YbWhMTlZxVUtUeGgxd1lBMXhFWlYrWUlxTXJWN0tGOURv?=
 =?utf-8?B?ODlsNTg3YW9DZVFhc1VKa3V4eEtmdXR3VFRXZ2N2QkJJTy9vZFpkbldhTHZr?=
 =?utf-8?B?QU9rOTRWeDF1akNubno0aGpNYjlQdkRwRFY2WlpkWFNoREVNNXE5M0tRLzBn?=
 =?utf-8?B?ei8zQUZ4WUh3bXlncktNYUcwOG15YlVOUVU4cUtvdXpCU0dCYU1PdjRSMTlz?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DA211B376DD7B469AB70E4EC8DE3134@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oEO8rkWf+2QO458APBGMglzg0Hkqa4Z+FjeoeTbtthGulyeQePuyR7L0q818gOdrdr+GQB1gFBJpKNUjj3YB6uBOi0/knNgEvH6azoVfEKJnOh8JaQWs+NJ/lxd3AHx2/+5pvDyT0YM6vLhGW9fVK2qagti/7woiS5n+fxCyCq64qP+JKxPpW0rWdxGBJ/j10hTfyp+OYl5PCkrzxthlcvGVwlABjwGMVih2ZHgGezVUMA5rHefYdu35kf084iNF3m3HiNIB/0NaM+v8Sf87Fn9mY/G9gvS2k90ummov1KMFmsyjNNZpLGTl95Hx86XX+Ix2d81/X5Rbipsn6ji6Tq1VBNPQA13wrEg+4xA2aVi3EnNKFJFFOPrhe/Y32V6x1n0GaOwoGhuA/3zJtjb3Wum1w/VgcbYQegIspEbgR83L23ZMW29A0ZzhQH6rLZvLw1utGXuz9SsPh9p3Dm+VAYb9JiGzmcYYUIDMIpchsUx3SVBSK3dCXldjlsUGiltAoe2/NIhBQVaWpsD7b0B+yijT8xUSeVcJyjf1wWU916aTxH/6n6/rm8L0uiai7r06A8sNAYYtMv5yyqkqmw6N+ha1R8Rn+Yk2TuygrndI/ExMlocQEzQ7yjKRbAtuYQEtRTd04cGtJ+VgjyvWlEfQTEQKqpICX1n/BWXqfrCPthzec/PiE4ejYtd7GQwi2K5M9qnF3y4QxVF5Qrb+wbOAkW05a1SGHXvwqHbdoIYx2hBqDcRnt2bsMH/zPe/8RxC8qKHBdOqobK/1EM3iyFlC8nyK1V/PNHCY0ZoYWf+1cicGrQq0qCQFlOIo3jrgMz6qwUbHMncROuo7xNXwHn5ED4j2ZsH7cwXkvA2nVrZKeVnxoP9/VGOHD0DqzYBt0v53
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1265f4e7-a701-4dc1-d460-08db42348fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 06:49:31.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8jZcjmRMAeaagUkQT4AGKGP6b+IOfqFLR92wuFFSqniWOA8TO5zl23gFTJqZqZ3imyhqZs+0HhEDd3KCDu3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7806
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIxLzA0LzIwMjMgMDk6MzgsIExpIFpoaWppYW4gd3JvdGU6DQo+IEppbnB1DQo+IA0K
PiBJIHVwZGF0ZWQgdGhlIGNoYW5nZXMgYXMgYmVsb3csIGFuZCB0ZXN0ZWQgZm9yIHRob3VzYW5k
IHJvdW5kcy4NCj4gDQo+ICBGcm9tIGQ0NDFjMGUyNDk2YzE3OTViNWFmMmI2YjhhZTQ2NzIyMDNk
NmFmM2MgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+IEZyb206IExpIFpoaWppYW4gPGxpemhp
amlhbkBmdWppdHN1LmNvbT4NCj4gRGF0ZTogVGh1LCAyMCBBcHIgMjAyMyAxNzoyODoyOCArMDgw
MA0KPiBTdWJqZWN0OiBbUEFUQ0hdIFJETUEvcnRyczogRml4IHJ4ZV9kZWFsbG9jX3BkIHdhcm5p
bmcNCj4gDQo+IEluIGN1cnJlbnQgZGVzaWduOg0KPiAxLiBQRCBhbmQgY2x0X3BhdGgtPnMuZGV2
IGFyZSBzaGFyZWQgYW1vbmcgY29ubmVjdGlvbnMuDQo+IDIuIGV2ZXJ5IGNvbltuXSdzIGNsZWFu
dXAgcGhhc2Ugd2lsbCBjYWxsIGRlc3Ryb3lfY29uX2NxX3FwKCkNCj4gMy4gY2x0X3BhdGgtPnMu
ZGV2IHdpbGwgYmUgYWx3YXlzIGRlY3JlYXNlZCBpbiBkZXN0cm95X2Nvbl9jcV9xcCgpLCBhbmQN
Cj4gIMKgwqAgd2hlbiBjbHRfcGF0aC0+cy5kZXYgYmVjb21lIHplcm8sIGl0IHdpbGwgZGVzdHJv
eSBQRC4NCj4gNC4gd2hlbiBjb25bMV0gZmFpbGVkIHRvIGNyZWF0ZSwgY29uWzFdIHdpbGwgbm90
IHRha2UgY2x0X3BhdGgtPnMuZGV2LA0KPiAgwqDCoCBidXQgaXQgdHJ5IHRvIGRlY3JlYXNlZCBj
bHRfcGF0aC0+cy5kZXYNCj4gDQo+IFNvLCBpbiBjYXNlIGNyZWF0ZV9jbShjb25bMF0pIHN1Y2Nl
ZWRzIGJ1dCBjcmVhdGVfY20oY29uWzFdKQ0KPiBmYWlscywgZGVzdHJveV9jb25fY3FfcXAoY29u
WzFdKSB3aWxsIGJlIGNhbGxlZCBmaXJzdCB3aGljaCB3aWxsIGRlc3RvcnkNCj4gdGhlIFBEIHdo
aWxlIHRoaXMgUEQgaXMgc3RpbGwgdGFrZW4gYnkgY29uWzBdLg0KPiANCj4gSGVyZSwgd2UgcmVm
YWN0b3IgdGhlIGVycm9yIHBhdGggb2YgY3JlYXRlX2NtKCkgYW5kIGluaXRfY29ubnMoKSwgc28g
dGhhdA0KPiB3ZSBkbyB0aGUgY2xlYW51cCBpbiB0aGUgb3JkZXIgdGhleSBhcmUgY3JlYXRlZC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4N
Cj4gLS0tDQo+ICDCoGRyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIHwgNDcg
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIMKgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJz
L3J0cnMtY2x0LmMNCj4gaW5kZXggODBhYmY0NWExOTdhLi41ZmFmMGVjYjcyNmIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQo+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jDQo+IEBAIC0yMDQwLDYgKzIwNDAs
NyBAQCBzdGF0aWMgaW50IHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcihzdHJ1Y3QgcmRtYV9jbV9p
ZCAqY21faWQsDQo+ICDCoMKgwqDCoCByZXR1cm4gMDsNCj4gIMKgfQ0KPiANCj4gKy8qIFRoZSBj
YWxsZXIgc2hvdWxkIHRoZSBkbyB0aGUgY2xlYW51cCBpbiBjYXNlIG9mIGVycm9yICovDQo+ICDC
oHN0YXRpYyBpbnQgY3JlYXRlX2NtKHN0cnVjdCBydHJzX2NsdF9jb24gKmNvbikNCj4gIMKgew0K
PiAgwqDCoMKgwqAgc3RydWN0IHJ0cnNfcGF0aCAqcyA9IGNvbi0+Yy5wYXRoOw0KPiBAQCAtMjA2
MiwxNCArMjA2MywxNCBAQCBzdGF0aWMgaW50IGNyZWF0ZV9jbShzdHJ1Y3QgcnRyc19jbHRfY29u
ICpjb24pDQo+ICDCoMKgwqDCoCBlcnIgPSByZG1hX3NldF9yZXVzZWFkZHIoY21faWQsIDEpOw0K
PiAgwqDCoMKgwqAgaWYgKGVyciAhPSAwKSB7DQo+ICDCoMKgwqDCoMKgwqDCoMKgIHJ0cnNfZXJy
KHMsICJTZXQgYWRkcmVzcyByZXVzZSBmYWlsZWQsIGVycjogJWRcbiIsIGVycik7DQo+IC3CoMKg
wqDCoMKgwqDCoCBnb3RvIGRlc3Ryb3lfY207DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJy
Ow0KPiAgwqDCoMKgwqAgfQ0KPiAgwqDCoMKgwqAgZXJyID0gcmRtYV9yZXNvbHZlX2FkZHIoY21f
aWQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmY2x0X3BhdGgtPnMuc3JjX2FkZHIsDQo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoc3RydWN0IHNvY2thZGRyICopJmNsdF9wYXRoLT5z
LmRzdF9hZGRyLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUlRSU19DT05O
RUNUX1RJTUVPVVRfTVMpOw0KPiAgwqDCoMKgwqAgaWYgKGVycikgew0KPiAgwqDCoMKgwqDCoMKg
wqDCoCBydHJzX2VycihzLCAiRmFpbGVkIHRvIHJlc29sdmUgYWRkcmVzcywgZXJyOiAlZFxuIiwg
ZXJyKTsNCj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gZGVzdHJveV9jbTsNCj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiBlcnI7DQo+ICDCoMKgwqDCoCB9DQo+ICDCoMKgwqDCoCAvKg0KPiAgwqDCoMKg
wqDCoCAqIENvbWJpbmUgY29ubmVjdGlvbiBzdGF0dXMgYW5kIHNlc3Npb24gZXZlbnRzLiBUaGlz
IGlzIG5lZWRlZA0KPiBAQCAtMjA4NCwyOSArMjA4NSwxNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9j
bShzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQo+ICDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIg
PT0gMCkNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSAtRVRJTUVET1VUOw0KPiAg
wqDCoMKgwqDCoMKgwqDCoCAvKiBUaW1lZG91dCBvciBpbnRlcnJ1cHRlZCAqLw0KPiAtwqDCoMKg
wqDCoMKgwqAgZ290byBlcnJyOw0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsNCj4gIMKg
wqDCoMKgIH0NCj4gIMKgwqDCoMKgIGlmIChjb24tPmNtX2VyciA8IDApIHsNCj4gLcKgwqDCoMKg
wqDCoMKgIGVyciA9IGNvbi0+Y21fZXJyOw0KPiAtwqDCoMKgwqDCoMKgwqAgZ290byBlcnJyOw0K
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGNvbi0+Y21fZXJyOw0KPiAgwqDCoMKgwqAgfQ0KPiAg
wqDCoMKgwqAgaWYgKFJFQURfT05DRShjbHRfcGF0aC0+c3RhdGUpICE9IFJUUlNfQ0xUX0NPTk5F
Q1RJTkcpIHsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgLyogRGV2aWNlIHJlbW92YWwgKi8NCj4gLcKg
wqDCoMKgwqDCoMKgIGVyciA9IC1FQ09OTkFCT1JURUQ7DQo+IC3CoMKgwqDCoMKgwqDCoCBnb3Rv
IGVycnI7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVDT05OQUJPUlRFRDsNCj4gIMKgwqDC
oMKgIH0NCj4gDQo+ICDCoMKgwqDCoCByZXR1cm4gMDsNCj4gLQ0KPiAtZXJycjoNCj4gLcKgwqDC
oCBzdG9wX2NtKGNvbik7DQo+IC3CoMKgwqAgbXV0ZXhfbG9jaygmY29uLT5jb25fbXV0ZXgpOw0K
PiAtwqDCoMKgIGRlc3Ryb3lfY29uX2NxX3FwKGNvbik7DQo+IC3CoMKgwqAgbXV0ZXhfdW5sb2Nr
KCZjb24tPmNvbl9tdXRleCk7DQo+IC1kZXN0cm95X2NtOg0KPiAtwqDCoMKgIGRlc3Ryb3lfY20o
Y29uKTsNCj4gLQ0KPiAtwqDCoMKgIHJldHVybiBlcnI7DQo+ICDCoH0NCj4gDQo+ICDCoHN0YXRp
YyB2b2lkIHJ0cnNfY2x0X3BhdGhfdXAoc3RydWN0IHJ0cnNfY2x0X3BhdGggKmNsdF9wYXRoKQ0K
PiBAQCAtMjMzNCw3ICsyMzIzLDcgQEAgc3RhdGljIHZvaWQgcnRyc19jbHRfY2xvc2Vfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICDCoHN0YXRpYyBpbnQgaW5pdF9jb25ucyhzdHJ1
Y3QgcnRyc19jbHRfcGF0aCAqY2x0X3BhdGgpDQo+ICDCoHsNCj4gIMKgwqDCoMKgIHVuc2lnbmVk
IGludCBjaWQ7DQo+IC3CoMKgwqAgaW50IGVycjsNCj4gK8KgwqDCoCBpbnQgZXJyLCBpOw0KPiAN
Cj4gIMKgwqDCoMKgIC8qDQo+ICDCoMKgwqDCoMKgICogT24gZXZlcnkgbmV3IHNlc3Npb24gY29u
bmVjdGlvbnMgaW5jcmVhc2UgcmVjb25uZWN0IGNvdW50ZXINCj4gQEAgLTIzNTAsMTAgKzIzMzks
OCBAQCBzdGF0aWMgaW50IGluaXRfY29ubnMoc3RydWN0IHJ0cnNfY2x0X3BhdGggKmNsdF9wYXRo
KQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZGVzdHJveTsNCj4gDQo+ICDCoMKg
wqDCoMKgwqDCoMKgIGVyciA9IGNyZWF0ZV9jbSh0b19jbHRfY29uKGNsdF9wYXRoLT5zLmNvbltj
aWRdKSk7DQo+IC3CoMKgwqDCoMKgwqDCoCBpZiAoZXJyKSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRlc3Ryb3lfY29uKHRvX2NsdF9jb24oY2x0X3BhdGgtPnMuY29uW2NpZF0pKTsNCj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChlcnIpDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBkZXN0cm95Ow0KPiAtwqDCoMKgwqDCoMKgwqAgfQ0KPiAgwqDCoMKgwqAgfQ0KPiAgwqDCoMKg
wqAgZXJyID0gYWxsb2NfcGF0aF9yZXFzKGNsdF9wYXRoKTsNCj4gIMKgwqDCoMKgIGlmIChlcnIp
DQo+IEBAIC0yMzY0LDE1ICsyMzUxLDE5IEBAIHN0YXRpYyBpbnQgaW5pdF9jb25ucyhzdHJ1Y3Qg
cnRyc19jbHRfcGF0aCAqY2x0X3BhdGgpDQo+ICDCoMKgwqDCoCByZXR1cm4gMDsNCj4gDQo+ICDC
oGRlc3Ryb3k6DQo+IC3CoMKgwqAgd2hpbGUgKGNpZC0tKSB7DQo+ICvCoMKgwqAgLyogTWFrZSBz
dXJlIHdlIGRvIHRoZSBjbGVhbnVwIGluIHRoZSBvcmRlciB0aGV5IGFyZSBjcmVhdGVkICovDQo+
ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8PSBjaWQ7IGkrKykgew0KPiAgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24gPSB0b19jbHRfY29uKGNsdF9wYXRoLT5zLmNvbltj
aWRdKTsNCg0KDQpzL2NpZC9pDQoNCg0KPiANCj4gLcKgwqDCoMKgwqDCoMKgIHN0b3BfY20oY29u
KTsNCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmY29uLT5jb25fbXV0ZXgpOw0K
PiAtwqDCoMKgwqDCoMKgwqAgZGVzdHJveV9jb25fY3FfcXAoY29uKTsNCj4gLcKgwqDCoMKgwqDC
oMKgIG11dGV4X3VubG9jaygmY29uLT5jb25fbXV0ZXgpOw0KPiAtwqDCoMKgwqDCoMKgwqAgZGVz
dHJveV9jbShjb24pOw0KPiArwqDCoMKgwqDCoMKgwqAgaWYgKCFjb24pDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOw0KPiArwqDCoMKgwqDCoMKgwqAgaWYgKGNvbi0+Yy5jbV9pZCkg
ew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdG9wX2NtKGNvbik7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmNvbi0+Y29uX211dGV4KTsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGVzdHJveV9jb25fY3FfcXAoY29uKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbXV0ZXhfdW5sb2NrKCZjb24tPmNvbl9tdXRleCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRlc3Ryb3lfY20oY29uKTsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gIMKgwqDCoMKg
wqDCoMKgwqAgZGVzdHJveV9jb24oY29uKTsNCj4gIMKgwqDCoMKgIH0NCj4gIMKgwqDCoMKgIC8q
