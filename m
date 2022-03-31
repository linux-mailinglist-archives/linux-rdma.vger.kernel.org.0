Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BC4ED259
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 06:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiCaEP0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 00:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiCaEPH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 00:15:07 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85F2993EF
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648698506; x=1680234506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O7JXcyR8YQyccGqbIrEyTlYgZaVLem4bwUzA2IA8rr8=;
  b=j01HF61qAMYr7xjrCFf5fd/9DLKPfwdd9aTS3SMpbmRh1EPIDs9pj2/s
   S+dHd4E/DquA/qiT5Guzx6ARp6hyuhKRVQepIw3taCDKFzu2VbBQpfWqy
   fzw+1zXKcHGWrva8s+rEZO1amLW7npugebW8QnyHNv0tJeoHnPfW+0ZRF
   6qqa2g1Ed2PJP58swVmXSLMBEXO6HhDWe+Pc7vdgxcGlbcSeVZAVHCtW+
   iE22ucgJCKVo/JkmGhrNdnAoVH4XthfQdewQ3x204Cuzc+36aVXsRjUEK
   cjwAkLV4CFBU+3/Q4Rx6sfFyGdYfu2kWbstIWMI/efunfPtqPXVaj5mW+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="53056088"
X-IronPort-AV: E=Sophos;i="5.90,224,1643641200"; 
   d="scan'208";a="53056088"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 12:26:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqh8EOrrz9tn2LHEqLVyg9t3NBRSzPQFZAxSAw01f1Vn2nHF6FDMPWK/+3bRBXF7ZKZTxC6FewL5PVgnpEfparliJQcBpZgkgl2WHhhS+/xQ0v7WEJGDhuh3lgXevxEZvAQhE1vJ0mDjYBnKKQO/l3dToE760bAQ0oLkoSWMjpXKy5Ex/mOlvbjsfBnuyyrgx1mtNjkHYuUtVZEvBpLSnqfrZvcLvciV6n3z5muKpyrfOCpmr1qrRylZmRCunm8yCV5WbZBhbJZvOJYYd88tpIDKIOkH5/0wf6BvD/q98DZqou2+v+i+CixOx/v7Utr9bdH7o4hb6/tvYTudiWhPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7JXcyR8YQyccGqbIrEyTlYgZaVLem4bwUzA2IA8rr8=;
 b=FPD3Gf4ffI7BAH7/izSfCte+2Pr0cBmlkzF82ICe2nc+txwr8Q/+8w1Fpouj0jL3jZPp4I9IFSvPaApEArkZRsuC0gpb9hh87AzdYLnTZXI4mnf/SXQbG3BszPyw2hy3aOt+K0N9pIvA6VlFPx/vWf1vUf/kgObxLq7ujQH0TtTwMe4iRevxCb7X3CM2AC4j6D0ZGtnZvqNvneoNqjezsnX3pNfVUzqv4Uwz7j+bKIHhGW3HfIw4hC6urIhATsboBM7DWSxxyZbEvkEDpHiSd1mRRsMIm78vGLuXKNwiJVEExOnvYzbepsHfLo805UEQG+Tai4pazLOW3vRyxTl9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7JXcyR8YQyccGqbIrEyTlYgZaVLem4bwUzA2IA8rr8=;
 b=pSGXj1zyCFUWEGkB9u2LdPHrFiQWyvosbr4G1RmJE3EajvtsfwaGe+JAuYltHCjDAW06PhFqlPL/CVV7fj2Nv3RiVLqken74m9RD/HryRV/ucyZwH3l9T53lRv3/Ue1wtE9T8v7jig5IxfnoKLtrOp38VcEh5AYcgvuiAefrY4c=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYCPR01MB9523.jpnprd01.prod.outlook.com (2603:1096:400:193::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 03:26:18 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::81d3:f9c:79b0:edf5%4]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 03:26:17 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Thread-Topic: [PATCH v3 1/2] IB/uverbs: Move enum ib_raw_packet_caps to uapi
Thread-Index: AQHYQrrbCbxufB+a+EWduTMw/8ueNKzXyLAAgAEP/gA=
Date:   Thu, 31 Mar 2022 03:26:17 +0000
Message-ID: <9f5adc78-f54c-79e7-c349-896ed2d41226@fujitsu.com>
References: <20220328154511.305319-1-yangx.jy@fujitsu.com>
 <YkQ7KnGtLvKmeID+@unreal>
In-Reply-To: <YkQ7KnGtLvKmeID+@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5cc3787-0536-4319-b522-08da12c637dd
x-ms-traffictypediagnostic: TYCPR01MB9523:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9523CE34EEA3F728129BAE4583E19@TYCPR01MB9523.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxUi+ySbRWg7ZH+vMcKjhSu6t/b+yYSuAPMvqggytflfnMk962pAg/SVoxbXxbmpt+U3HgO+o8z7aJnx55YRqBKDeZoRHNRST9hFL2Qt0PumRjVRW+S/5iSBswu/K+4VbxpKwGQRf3YgqB8hDcYHN+xIDhUj/8sZgW5bPsMtD4tZD8D1So2RGFP55ZfLub12tJcyAON4LOWuRfWIBEfmmmWmx6nlyP9BIDLkDcS4MQYUkGeY5u55al9sHYOz+lTEO1dsuHJO3NOFjgmnDYoQCn0VaPQxNj3NBwHNBgz0pQpOpNRB+aWJZyFmVaSKu+kh8q1ag7AySHLG3Yq5STYrbTvhWnY9yI/gvLm7cirhO8fgU72bE7CVx/ZOlhf3YQLnMdZHRwRP5VjgdmCCQeC1jqBC7j823MmgBby2XrLA+w3Mi8BPjOzP/2f2/embkAWTRN75fbE/RSTnRysA0y/mjyr0sJhYTmA9p0kUtHrQaKKe6hhNECduuYAbWiv6ajbBwPiYHmbz3TvbGcWfw6fJEiUj6k3sc3N41vA5i7/I+VftQDmReZ8fvKEYw2wE4EKF0czncnYJNUV5JeHsqyB9YqThRuKkAiDiD/t/3MIAh0u5TT4D1OHZonnOqjyX5D5F/2ihRM990swdbLVrXyvdSU9vg4VsxGw9Hkkhi3W0N3XfRBmOvc/3qCMsGynLoGoBIidfKtoxWX1ayBDYST144qPhaH5TJ+YewyK2JuT7U9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(36756003)(2616005)(85182001)(6486002)(64756008)(508600001)(54906003)(91956017)(31686004)(71200400001)(6916009)(66946007)(66446008)(66476007)(38070700005)(5660300002)(4326008)(8676002)(316002)(86362001)(31696002)(66556008)(76116006)(122000001)(186003)(2906002)(38100700002)(6512007)(6506007)(82960400001)(83380400001)(53546011)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTBpY0Fwckd1N0c2SE1ER0ZhSXdoWHdoZ25zMkxGNlJCd0RzYitYVzRKOWlu?=
 =?utf-8?B?M0JSY3ljSDNxaGp0bXI4ZlVybHJhaUJNQStXdmdRWW5QQlhzdXZiVnZFM2xT?=
 =?utf-8?B?R3REMG9TM1hzaWNHVXZ0dnZBS001SDd3TUhTaDhoNzM0VVhiSnV1ZFJlRmdO?=
 =?utf-8?B?QXp6cHkvUzJNN29kakxvNkh6Z2RFTS9QbzVXRVhFTHJYT0Z5T0kvT2ZMTU8w?=
 =?utf-8?B?RnJ0aklaNTB0M1JGM0ZpNGNoMFlTVHlyaFVxQlJZQk0zMUY3Q2toMDg3VTR4?=
 =?utf-8?B?S3NGVE1kNEFQQXQzS3BpcjdrTmljN0JtTWkyd21Qc0dlUDErcktwcWQrNHNV?=
 =?utf-8?B?bTg2NXFNZ1BWUSthQ0ZPVGpPbkUzRTU3QUMra2czZEZhT1B2bk1IRDA1TnJ0?=
 =?utf-8?B?dnpwVTh0TFJpV3NLcmNPWDB1MWN4YnlSRzVzd3RFdnY5VEFvdzVLTmx1UlJt?=
 =?utf-8?B?VDlYTkY1YkY3bS9RTStGd2lqSWl0NkZmNS9GUHRxVkE1MjhTZ0JNcythbFA0?=
 =?utf-8?B?OHphM3BOTm92QlRRZDRsOXFhUDdrZElCQ3Q5S2xOZ3JtVm9yTXVNaXllTzBm?=
 =?utf-8?B?eVlZZ1ltT0FYUG8xSTFvU1FtTWlsU045RE9TTlJibThxd3BQMHRycVZxWnQx?=
 =?utf-8?B?b0I5UUNTZmZheEpUcW1WTkV6U2pTblUzVGRQbkhCaVY5c3B0cnFMK0VrOCtG?=
 =?utf-8?B?anVDS0JPT05UM1RyWm5Da1VmZ3Q1eXpQNjN1bVYxbGQ5bW9MTllDWmM3eE80?=
 =?utf-8?B?Q3ZuQitJRTZYbHhaYVZ5Qk4zbTF0NWQwZ0JZcTRrakRmL3hIam9PZm1iZzRw?=
 =?utf-8?B?SzFjaGZXUFBjLzl6czREdHRpemw3YSs5ZSt5Ym5hVEorY3Zvd2R4VzdwVUhn?=
 =?utf-8?B?ZU1EemVLdXBOWFdqV0VQQkwraTR5OVBhL3VhYkVvTHk3V0NHMFBlbkcyY2VE?=
 =?utf-8?B?SnFFK09ZdjNVMERIa3lEajVkMUkxd3VwdUlEY0xIYTljeTNyMG0rdUI2dXJr?=
 =?utf-8?B?dnF3bGhubjMrQ0w1RGRoeGZhU2RlcjNZNktJdStJeDdtdkdndVp3Sk1VaWJy?=
 =?utf-8?B?S1NSblRhNzlmYUVsdVZHa2drL2ZiWXBYamJKUFdxR0RxbXVjd2w2a1c3TW85?=
 =?utf-8?B?RUV3cWM3djlUWFFhVFd4bDNPeHR3bTVVdHhvTit5anNMcTRYUUw0d0d6U1VI?=
 =?utf-8?B?SGt0SlpGbHpzeHIzVTYvVDBad0VVdjM0dHZieVltbW9FMEFqajB6RVlpcmlQ?=
 =?utf-8?B?QUFjbjlsbk8rQTVoc0ZwWFA1NGtCTVl2L0pTNGJhd3pLZk9IQlpXeVpQZ3hR?=
 =?utf-8?B?MHdrY21nY2xUM2J3NlM4NjJpRDdWaHprbnRxYUJieVZOR09FMFhCNWVyVzA1?=
 =?utf-8?B?ZkNnZElWeUlTVVVaSEtkUVYyYzhPdFdMSis4SXYrejc2bC9jdVBTeE5zWjc0?=
 =?utf-8?B?U1o4VGtSY2ROdmY3VjlkL09aUkxCT2k2WXdjSXN3d1ZuVzlzeitCbXgzWnJF?=
 =?utf-8?B?VXcvU2hEQ1VvSTVGdkQwNlh1NGxyV2JxTG93NGZSaVZUY1B5ZnM3b2oxUlc3?=
 =?utf-8?B?ZDVHcnVNRWZIQmhyYWxmS1hBQkw4SVd5bkNSM2grNWJ6Q0owMC92TkVHK3Zt?=
 =?utf-8?B?ODBZWC9nYlYxRkorYXpxRFpiWmphYWh3TGpKOE5BQyt4TFZ1K0R2NTJKUU5Y?=
 =?utf-8?B?cTR4VUwrYk10VXJIaHJTZFk4d3c3cXRSODNOQjFQQUhUanJYcUtIODdqYkFO?=
 =?utf-8?B?T0dWRXoyeGY3S2E3blU1dWxmTEtxSWl0Q1B6K3o3Nnp0elh1bndZaVB5enRp?=
 =?utf-8?B?MFZrb2NtM1Z6Wml4Z1NOMElnaFJCVWUwdG1NRmk4SG9td1c1NGNWSjVzNmV4?=
 =?utf-8?B?VFBqMjVTb21WdXpKUVdDa0s4U0FWLzdyWndWYStQN0pGZldjQU56Z1BNUVpZ?=
 =?utf-8?B?WGFCZUhSOWdmSm1BV3RhNzVyS2t3SThNUjR4M29VQXVrWUVLdnc1TlRlRHhM?=
 =?utf-8?B?K3Raak5udjVRUVMrNzFYT29nUE53Vno0YXFObzdScjVOQlFraDZSbkZ0bTJF?=
 =?utf-8?B?M09OMFVrTEZTQm9LZDFuckJQRDZvMTRleU9teTA4YldYVEkyY3M2RFpMZmJG?=
 =?utf-8?B?WENWeGNpU2NsUGRBSGVOdFk2a0FrTHJ4TTRaZWxPVW5xTzR2LzFySlBFYTR0?=
 =?utf-8?B?R3FGUGdLV2JqTTRvVHBITnNRMW4rczhSZlNoeUZEcTJWT3J0NVRseDh3d25B?=
 =?utf-8?B?SlZhaTNPQWFGdGZuQWdscXpZdTM3Y01mYU12a01ja1h1OC9zbzhMQ0dzMGJq?=
 =?utf-8?B?MC8yWkdEOU5DT0xvUXRRazRyTlR6WHEydCtEcUxOQlJhRHZ0RUFKeEtQZkxj?=
 =?utf-8?Q?ZI9HkjpQLQA3Ccp0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B84DEF00AC99604792710C5A0688A209@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cc3787-0536-4319-b522-08da12c637dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 03:26:17.4919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOhd3IFUz7LuAxcKjJHerslDXJkgIqfVctVnBN5mO/1U/rmqxvba2Qf01pDmTZM4VkSkY0WSa7tLGvtveHjitQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9523
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzMwIDE5OjEyLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDI4LCAyMDIyIGF0IDExOjQ1OjEwUE0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+IFRoaXMg
ZW51bSBpcyB1c2VkIGJ5IGlidl9xdWVyeV9kZXZpY2VfZXgoMykgc28gaXQgc2hvdWxkIGJlIGRl
ZmluZWQNCj4+IGluIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+
PiAgIGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKy0t
LS0tLS0NCj4+ICAgaW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5oIHwgIDcgKysrKysr
Kw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oIGIvaW5jbHVkZS9y
ZG1hL2liX3ZlcmJzLmgNCj4+IGluZGV4IDY5ZDg4M2Y3ZmI0MS4uZTNlZDY1OTIwNTU4IDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmgNCj4+ICsrKyBiL2luY2x1ZGUvcmRt
YS9pYl92ZXJicy5oDQo+PiBAQCAtMTYyMCwyMCArMTYyMCwyNSBAQCBzdHJ1Y3QgaWJfc3JxIHsN
Cj4+ICAgCXN0cnVjdCByZG1hX3Jlc3RyYWNrX2VudHJ5IHJlczsNCj4+ICAgfTsNCj4+ICAgDQo+
PiArLyogVGhpcyBlbnVtIGlzIHNoYXJlZCB3aXRoIHVzZXJzcGFjZSAqLw0KPiBUaGlzIGNvbW1l
bnQgaXMgbm90IGNvcnJlY3QsIGJlY2F1c2UgeW91IGFyZSBub3QgdXNpbmcgdGhlc2UgdmFsdWVz
DQo+IGRpcmVjdGx5IGluIHVzZXJzcGFjZS4gWW91ciBuZXcgaWJfdXZlcmJzX3Jhd19wYWNrZXRf
Y2FwcyBpcyBzaGFyZWQNCj4gYW5kIGxvY2F0ZWQgaW4gdWFwaSBmb2xkZXIuDQoNCkhpIExlb24s
DQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLCBJIHdpbGwgcmVtb3ZlIHRoZSBjb21tZW50
IGRpcmVjdGx5IGluIG15IHY0IA0KcGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNCg0KWGlhbyBZYW5n
DQoNCj4+ICAgZW51bSBpYl9yYXdfcGFja2V0X2NhcHMgew0KPj4gLQkvKiBTdHJpcCBjdmxhbiBm
cm9tIGluY29taW5nIHBhY2tldCBhbmQgcmVwb3J0IGl0IGluIHRoZSBtYXRjaGluZyB3b3JrDQo+
PiArCS8qDQo+PiArCSAqIFN0cmlwIGN2bGFuIGZyb20gaW5jb21pbmcgcGFja2V0IGFuZCByZXBv
cnQgaXQgaW4gdGhlIG1hdGNoaW5nIHdvcmsNCj4+ICAgCSAqIGNvbXBsZXRpb24gaXMgc3VwcG9y
dGVkLg0KPj4gICAJICovDQo+PiAtCUlCX1JBV19QQUNLRVRfQ0FQX0NWTEFOX1NUUklQUElORwk9
ICgxIDw8IDApLA0KPj4gLQkvKiBTY2F0dGVyIEZDUyBmaWVsZCBvZiBhbiBpbmNvbWluZyBwYWNr
ZXQgdG8gaG9zdCBtZW1vcnkgaXMgc3VwcG9ydGVkLg0KPj4gKwlJQl9SQVdfUEFDS0VUX0NBUF9D
VkxBTl9TVFJJUFBJTkcgPQ0KPj4gKwkJSUJfVVZFUkJTX1JBV19QQUNLRVRfQ0FQX0NWTEFOX1NU
UklQUElORywNCj4+ICsJLyoNCj4+ICsJICogU2NhdHRlciBGQ1MgZmllbGQgb2YgYW4gaW5jb21p
bmcgcGFja2V0IHRvIGhvc3QgbWVtb3J5IGlzIHN1cHBvcnRlZC4NCj4+ICAgCSAqLw0KPj4gLQlJ
Ql9SQVdfUEFDS0VUX0NBUF9TQ0FUVEVSX0ZDUwkJPSAoMSA8PCAxKSwNCj4+ICsJSUJfUkFXX1BB
Q0tFVF9DQVBfU0NBVFRFUl9GQ1MgPSBJQl9VVkVSQlNfUkFXX1BBQ0tFVF9DQVBfU0NBVFRFUl9G
Q1MsDQo+PiAgIAkvKiBDaGVja3N1bSBvZmZsb2FkcyBhcmUgc3VwcG9ydGVkIChmb3IgYm90aCBz
ZW5kIGFuZCByZWNlaXZlKS4gKi8NCj4+IC0JSUJfUkFXX1BBQ0tFVF9DQVBfSVBfQ1NVTQkJPSAo
MSA8PCAyKSwNCj4+IC0JLyogV2hlbiBhIHBhY2tldCBpcyByZWNlaXZlZCBmb3IgYW4gUlEgd2l0
aCBubyByZWNlaXZlIFdRRXMsIHRoZQ0KPj4gKwlJQl9SQVdfUEFDS0VUX0NBUF9JUF9DU1VNID0g
SUJfVVZFUkJTX1JBV19QQUNLRVRfQ0FQX0lQX0NTVU0sDQo+PiArCS8qDQo+PiArCSAqIFdoZW4g
YSBwYWNrZXQgaXMgcmVjZWl2ZWQgZm9yIGFuIFJRIHdpdGggbm8gcmVjZWl2ZSBXUUVzLCB0aGUN
Cj4+ICAgCSAqIHBhY2tldCBwcm9jZXNzaW5nIGlzIGRlbGF5ZWQuDQo+PiAgIAkgKi8NCj4+IC0J
SUJfUkFXX1BBQ0tFVF9DQVBfREVMQVlfRFJPUAkJPSAoMSA8PCAzKSwNCj4+ICsJSUJfUkFXX1BB
Q0tFVF9DQVBfREVMQVlfRFJPUCA9IElCX1VWRVJCU19SQVdfUEFDS0VUX0NBUF9ERUxBWV9EUk9Q
LA0KPj4gICB9Ow0KPj4gICANCj4+ICAgZW51bSBpYl93cV90eXBlIHsNCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX3ZlcmJzLmggYi9pbmNsdWRlL3VhcGkvcmRtYS9p
Yl91c2VyX3ZlcmJzLmgNCj4+IGluZGV4IDdlZTczYTA2NTJmMS4uZmY1NDk2OTVmMWJhIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5oDQo+PiArKysgYi9p
bmNsdWRlL3VhcGkvcmRtYS9pYl91c2VyX3ZlcmJzLmgNCj4+IEBAIC0xMjk4LDQgKzEyOTgsMTEg
QEAgc3RydWN0IGliX3V2ZXJic19leF9tb2RpZnlfY3Egew0KPj4gICANCj4+ICAgI2RlZmluZSBJ
Ql9ERVZJQ0VfTkFNRV9NQVggNjQNCj4+ICAgDQo+PiArZW51bSBpYl91dmVyYnNfcmF3X3BhY2tl
dF9jYXBzIHsNCj4+ICsJSUJfVVZFUkJTX1JBV19QQUNLRVRfQ0FQX0NWTEFOX1NUUklQUElORyA9
IDEgPDwgMCwNCj4+ICsJSUJfVVZFUkJTX1JBV19QQUNLRVRfQ0FQX1NDQVRURVJfRkNTID0gMSA8
PCAxLA0KPj4gKwlJQl9VVkVSQlNfUkFXX1BBQ0tFVF9DQVBfSVBfQ1NVTSA9IDEgPDwgMiwNCj4+
ICsJSUJfVVZFUkJTX1JBV19QQUNLRVRfQ0FQX0RFTEFZX0RST1AgPSAxIDw8IDMsDQo+PiArfTsN
Cj4+ICsNCj4+ICAgI2VuZGlmIC8qIElCX1VTRVJfVkVSQlNfSCAqLw0KPj4gLS0gDQo+PiAyLjM0
LjENCj4+DQo+Pg0KPj4=
