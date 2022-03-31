Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4095A4ED396
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCaF6C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiCaF6A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 01:58:00 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FA197AD4
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648706167; x=1680242167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rqu8tsmvUV3Jfwhd+7rf+KS1PdzERdxJ87i/LMVG85s=;
  b=wXqbT+AuIipxJc0L1wG9zJDKI69k/q8hUcOx/hQ0/x4SDwYqXvGhaarP
   C/+zNsbDKJDjgAjX/t/o5/oxdrvxaf1GRBtAu9eUIRLe9blilDTohzAO5
   pBZzNp7fNt4EFSoTCFLlkYYGA/5u8CTvUIZpSZsZxFDAh2eJ64fmAvQVw
   TxT5ldfWiwxm5p46iXFAKVjHpGlCT0i78CjEXHiiT/UlVDaQcSSZQ0pi2
   Epo+82GEVTTU82lD967mPACpuCywZhn4Y+XAt5Mvyt4ZiulglpRL+UiU9
   TlBmtdyz0CDWlN5xyne6glRQOeJfuCPRjUciweeJFvblpWNGf/jmKc7fU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="61176804"
X-IronPort-AV: E=Sophos;i="5.90,224,1643641200"; 
   d="scan'208";a="61176804"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 14:56:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRiuMULlAT0IJrPazvGreqcHZWMb5bhac8ld733QBkg4YaPdORnNwZ1OahB4ms0OzyyFDqcIjklW6PN5FNhteUsW4B4V0Ik0HfTtnkKxxc+vQr5wXqo5URZehgcxCUJoIig9pInEpNoWZkXzm7gnEloW286pCywxp6jVsEfpjXsGgErJHXm3JCEcT3qvoIkKJbVsfKpdckGAVw/tUeo5ZqeXZh92GwUEOoSlAVjR6qK+cFwv6KATFT8yj/rkbl9HdttFFWVZGegOTX7LkPuY/bBvIYZnWEvSDgeYJmE4srEJ4iLdXxVjVGB26kJxKrTUJS4a/TXV3XE1D7235Sn9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqu8tsmvUV3Jfwhd+7rf+KS1PdzERdxJ87i/LMVG85s=;
 b=ehWXq70IRlG2kWEpEeciOhFx9CfEC55MR0TCur1nvxoYLOgHz4+xZvhoVAqkvmTvKa3hsCWdoq2g0mRgj4MHCR3fmmTx6HHXcPkYbRPYfXFh0vPefmrSdI8lM6n2tEmjvLZTUMIcT9PyWP46l6uf/VNd4iwnRqIo2Bj4W+Xso7DbzUqbRU2K7QTpeJf2Pez7yf8k87iVnitiJC+eFpWZas65ZBRomhf0NzmpOtYR63yUS6dFXUfl5E/Fyhb+JFnu3z2fkTMHc4BgZ98CRZCp+MctJmFRxZ2pbMSmQNSukCSxd0L3MVQ+1mK/dyew7vKVC0I4HPYb3p9A7bA0N9oXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqu8tsmvUV3Jfwhd+7rf+KS1PdzERdxJ87i/LMVG85s=;
 b=UJg7KQ2kDrCZ78E4eESMCltqKTde2eUpWFHiHvZIKiZ+oMhTFffCBNrP6rLrK5KDgazeJzlMD2FrI2mtwbxYmrK41fIRG1KS0r7UgGfXPyctShaMlCDrW6kVTzvuyB2dk6VWOLiQpKXNmlYyFuCNju3veSZW8k2BA0V1XX/nz8o=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYAPR01MB2895.jpnprd01.prod.outlook.com (2603:1096:404:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 05:56:00 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 05:56:00 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leonro@nvidia.com>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion on error after getting
 a wqe
Thread-Topic: [PATCH v2] RDMA/rxe: Generate a completion on error after
 getting a wqe
Thread-Index: AQHYQrb/aNPk9Q3LRkGYexQuVozBMazVIwSAgACZGoCAAdJXgIABdBiA
Date:   Thu, 31 Mar 2022 05:55:59 +0000
Message-ID: <e54bd3f3-92be-8574-894b-c5fb7aa59e58@fujitsu.com>
References: <20220328151748.304551-1-yangx.jy@fujitsu.com>
 <YkICq+3JmsTSrELB@unreal> <ce13b0dc-6e1e-28a1-75f3-dafaa044c230@fujitsu.com>
 <YkQKS0ZaB8inihGP@unreal>
In-Reply-To: <YkQKS0ZaB8inihGP@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e611875f-a06b-4a32-5282-08da12db21f8
x-ms-traffictypediagnostic: TYAPR01MB2895:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2895FDBF07C13296354AC60A83E19@TYAPR01MB2895.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bd5prJBclM7bpL1P+1/LdPw02mxUwU1Zin+4by8M9XDUVqoFGBHf7RlIXHYE03/k3jsrwB7q9JZjEgYkpRLKFthcSztUVpJ6mhKSdzmvtGdBfNxySis124upQIldSCMVrdgy+dc231w7LdHWdkE0biSBhZyBSnVNHaQK6/RkB7IaOtq6G4OOiy54SUZXStHRPzqw71I46+uKKh9zroteda23pHYUul/OTdxj5hmXmuKT+AbN+vst7JFQwnAvrev41O86eRwCR8DMqbyAG/EBBnYROR1znkvXqIC0ba8Euhx6+Arh3+sIfPpIkx0LGKHH/BZNL24Uc36Gw+nfTQP97q7MW6GxbO9TNcHvo2Y04Zz6HsjSqmXFz4ievMkCFtft/s0kGaoycsh9vEvUlfmWmDKdsPQYuJ9GIQepibRcDQaLFRQuI1+k4mFevnvQEY9Thr+3GWPRSpEChhwOvPQvB/tO8+qC98tSLxztAhJeOKQSgCTLMrgS6xpGsznsd1bs7t1PneDScPFOe9MpWioQLpgHEMfKhfQVXXi9WvcV8ZADXqI5X3kozsg9UQCCICoQSpPGdfT8/dQ1hG5xmeBeklwm/ohC6rGa+Dqa7VeRi9Yc3+x63g06/+klG7wB0i79TGc+8xTtTU76GMl7fDI+zXIjClppMWr2udc6Uf2/IUC8P+FPiSNs0FBQP/inj2fv33aOZJQ1+pCUAV4nmdVRbD70FWu7EjKZr3dtEp0ZNn87s3H6zSMMV6d/DxYL/KOJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(5660300002)(38070700005)(83380400001)(4744005)(85182001)(6916009)(2616005)(36756003)(31696002)(6512007)(8676002)(82960400001)(2906002)(38100700002)(31686004)(86362001)(26005)(186003)(54906003)(122000001)(71200400001)(8936002)(6506007)(6486002)(66946007)(53546011)(91956017)(64756008)(4326008)(66446008)(76116006)(66556008)(66476007)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2x5SWlLVGZHQ2g0dGlodGlReWpEeGxsa3RKUm8rOTlqRWRHek81ZTlJaWhr?=
 =?utf-8?B?R1FyblJrQlZhbVBUY0pzdDhJZzZGUzF5Ykh3SVdIcVRhdFExMWVhaWtmRGpa?=
 =?utf-8?B?aWl6UFg4cVFWUXVsekVaMHJNWWI3dFhiVWpHOUhrVmg2TVVsVHg5STcycnd5?=
 =?utf-8?B?aTNPSW14WEdLV0tlaFA1elFYSnkwRDU2Q201cS9adCtIejhkSEVheE92QXZy?=
 =?utf-8?B?ZGF1Q25oRnBnTjRmLzZYSmVxK3A4T1FCTmJleTE1V1MzRFgzY0lDenM5NjV3?=
 =?utf-8?B?RHZyMWlna2gxSEFmWnhlQ0xCWWswSU82UVZxMjg3QUJDNmFrQTVraGlrZEpx?=
 =?utf-8?B?bE8rLzNTa0JoeEJZVTJUSGlwekQycGtuekpNSFhxaDhkQTQrdHgydk1kVjht?=
 =?utf-8?B?Z29ydFVHS0p2V3c0YmFmdGYrRjRpd2hycVR0YTByL0JncmR6b29qMDd0LzJU?=
 =?utf-8?B?QzJnMVJaWVVsSFI0UVhEd2NVb0JYQlYwNFhnenArWFV1a0RRblo5NmZPbzhR?=
 =?utf-8?B?YzNuNzJVaUtPUUJJV0JuK3A3cVlJcVQ1Q2ZDZHgzQmpaUW5xektaaDlMejZL?=
 =?utf-8?B?cGJQM1BVNkFMQ0Z6NkVQZG42VnREUWF5NWpWTG5pU0orRlpFSmlCa05DUFA0?=
 =?utf-8?B?b1poc2hZNCtxMVFhaFQ5NjU2OFpNOEd1ejhjZVFHVzB6dFlKMlZ1c09VaWhF?=
 =?utf-8?B?cXVxTHFMMlMwRlhVQ1NOYjBGU3E5Z2xzZCtid2dXdDRTTW1xaGErcDhKMUl1?=
 =?utf-8?B?Z3ZMRkNXdWs0bHJPRFRpODlNWWRkbEpJQWoyYzNUdmZqWXEwMlBxdFBUVHpN?=
 =?utf-8?B?N1kxdjNvdmhHTEtUWkVzM1h6eURVSi9TZFU2WWE5MXVUQUFuWmlldzM1L3Ju?=
 =?utf-8?B?cWc1bE5BeVYrU3NkZUQ3cjdmSjJsc21uQlBBQ2dWUjF6a3Fvd3pYMkRnRUxr?=
 =?utf-8?B?eDV6Qk9VYnJOc2xoc0hlT0Z4M2pXb1FtNzMvbXJJbGV2YVdqM0kwMXFoOTdD?=
 =?utf-8?B?V0NEUkUwWFM4UnUvV2QzWUw5K1NSTk9CS0s4L3ZheHhacEdlNm55b2sxOGhx?=
 =?utf-8?B?YlBmNGYzT0dQMVNJN2JhLzJrL1c4ZVBoT1h2MGsycEp4VDdocjNVY2lXRkRS?=
 =?utf-8?B?aVN3NmlPRFhYREJKZFUzYzUza3ljMitFUEV1eFJWOVhQQ3gyNGNWYnNmMmJx?=
 =?utf-8?B?RXNUUHorYkZHVTZMbk9XcWc3bDZ2b2VxM2gwZWc0Z2t3ZnU3QVZVeElIQkNa?=
 =?utf-8?B?RUh1Qkg3Vm9vQ2FVRitkSDlHbUZFbUxBZFQwZ0pVYnoyQTl6N001bmZBOEFm?=
 =?utf-8?B?bHRWVXpzRkV6cHYwMitPbE1Ha0pYT0M3UnN3MlJjQ3I1N1BHRzBhVWZmQVBs?=
 =?utf-8?B?YXdJZkxzdi9oMkRVL2kxQU5zeXlqOVRHWUVhWTZqZVVwcU1EeGliVzVhNjZW?=
 =?utf-8?B?YmR2UW5tZTFhYWNETzN6VXQvY0Ntc1hVODFFazdvSUVtZ1dwaTNNM1U1Q0R5?=
 =?utf-8?B?SnZCUDRoOStxaGJXK1hjOFNaQmlGc3RlclZMNis0WGZYdTJzYkE0YWxXWWpx?=
 =?utf-8?B?SmdFdWFpZVEya3BxMHhmWnkrdDNqYUZMc2ZUYUVVMll5Z29mYjcxOFJKTEd4?=
 =?utf-8?B?S2lZbEpKdWpVN1V1c045bHdrQWQ1VkovYWYrWmR3dWkwajUwNHJWbEhmbmFM?=
 =?utf-8?B?N25PK05RMHZnYXRHUWpPanBvNzZwbmdkdW5pWTVjUXRTaDZ2cUh4aTJ3RjlR?=
 =?utf-8?B?MDArS0lZMGdVZ3l3d1p6dXh3QnFNNklLNmRwM1krREtDdERMVndnZlFydFNG?=
 =?utf-8?B?NGlyYy9adWdiejFrdVcvM0NweHpUNm9ITGhPYUNrVnpmdkplcDVBSU5NNkZ1?=
 =?utf-8?B?VGZnNlp5M3BObUJjMnhnNU0zcFZFUHN1aTgzWW9KTm9iUGhsVEZGMUY1VndT?=
 =?utf-8?B?ditVM0JnRXFIVVorRHFtS202K2xpNlZxazN4d1Y4NS9mWUpFcndFK244SDcv?=
 =?utf-8?B?eEZOaGlBeFN3Vkk0aGxFSzZjSEhPQTBZcjRleElSeFBYZk94UkZFd1Z4OHNa?=
 =?utf-8?B?ZkJob01tcVJVUW92dG5aa09DdFpqZ3FhZjdpSGlkT05TcldteWF2S2RldjEr?=
 =?utf-8?B?SFA4SUdxMmFzVGdTZm81S0lGZFptaTh2dEVlUmJCKzBsUFl3bHZKTUdPTGVs?=
 =?utf-8?B?VUJYdWNlS0Vub2tTdWpJOS9oTEtJdmVicnh1ZHI1blRKMkJ4Tndrd3ZtclRN?=
 =?utf-8?B?N0YyZTl6NlZPT2w3cEl6K21YZ0d2c21Zb0pWTlR6ak5Cd3NvUEpleGZZa09H?=
 =?utf-8?B?SWo1UXVxdlVSTi9qWUxpWHc1bkZvNFlrSVNHY29JN1BVL0ZoNi9ZS2JyQkpl?=
 =?utf-8?Q?0ldn7eHLEwvRw++8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE16AF913D76D4EBB889D407E50DA0C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e611875f-a06b-4a32-5282-08da12db21f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 05:56:00.2782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BHumhlwK4GfSSt1qcpI5YuGrqgXgf7xHgNghISHvn/i7RRWKqDCAAiSgASpn6oi07SHDxejeUtwZpIFWpf7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2895
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzMwIDE1OjQ0LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IFlvdSB3aWxsIG5l
ZWQgdG8gb3BlbiBJQlRBIHNwZWMgYW5kIHRyeSB0byB1bmRlcnN0YW5kIGZyb20gaXQuDQo+IEJ1
dCByZWFsaXN0aWNhbGx5IHNwZWFraW5nLCBJIHRoaW5rIHRoYXQgaXQgd2lsbCBiZSB0b28gaGFy
ZCB0byBkbyBpdA0KPiBhbmQgbm90IHN1cmUgaWYgaXQgaXMgcmVhbGx5IGltcG9ydGFudC4NCj4N
Cj4gUGxlYXNlIHJlc3VibWl0IHlvdXIgcGF0Y2ggd2l0aCB1cGRhdGVkIGRpZmYgYW5kIGNvbW1p
dCBtZXNzYWdlLg0KDQpIaSBMZW9uLA0KDQpJdCBzZWVtcyB0aGF0IHlvdXIgY2hhbmdlIGlzIGJh
c2VkIG9uIG9sZCBjb2RlLg0KDQpBZnRlciBsb29raW5nIGludG8gdGhlIGxhdGVzdCBjb2RlLCB0
aGlzIGNoYW5nZSBzZWVtIG5vdCBzaW1wbGVyIGFuZCANCmNsZWFyZXIuIGRvIHlvdSB0aGluayBz
bz8NCg0KQmVzdCBSZWdhcmRzLA0KDQpYaWFvIFlhbmcNCg0KPg0KPiBUaGFua3M=
