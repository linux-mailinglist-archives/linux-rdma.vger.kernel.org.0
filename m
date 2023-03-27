Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310196C9ADA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 07:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjC0FYK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Mar 2023 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FYK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Mar 2023 01:24:10 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Mar 2023 22:24:02 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25249FA
        for <linux-rdma@vger.kernel.org>; Sun, 26 Mar 2023 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1679894642; x=1711430642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/jW3BCRCSKvYePIQmYP8oxNytBtQXPEXEwgTRk4WGJ8=;
  b=gtLhd2n4ly2mEbvminjS141RhCls0o+NHhDXI4g5rVqIhKLKx11aBW+9
   N2803n9s+FAQNYiS/W3FcOYBiMjssqau+nJkAASetHkgjp93f7b1qbKTv
   TlYPp/x31+v/5TEl0JHZT20w/gLDelGsAuFvgGQhdOROieRYXrlbKShOu
   CobaKnG9XNRqEsvn1kvJVficIlbcMVzu9fO5Z1MIqcf2NI2fkjWQeO+lf
   88t5e2IG0i2hgWqZ+FUXFCO9dqx65Pe8AkJ6vT4JYGFF36W0rMhHKjt5V
   Yr68pb/MJ0HQU9rhDpfkledfBhfFOI1QOX6PqkY5CGHzIDa6xFS2CYbiI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="88462737"
X-IronPort-AV: E=Sophos;i="5.98,293,1673881200"; 
   d="scan'208";a="88462737"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:22:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5ED6J3o8T10aTVyn1DPMvwoteYv9/Ogly8E619VBl6uZ2v6QZ9LatES7SJ08meTnvL8mDCuM6t8wzPmuIsKVaeQVeAK+JicWrZYt3sySHfD8sSBanbkf0jaVHTRNQFBtuUWUY4E3ey/hmubOQZLgQd0CRCmqYmWz3TWEr8Mbc0VtpsaUA6xLyzOo0wgPBkg/Xl5EoNxF2oIE18IbW+I4rSQx+4qb0yNXtqhFOAcH1h6FjBVoxpNEK1zj7ffcbIsgXEdhnPvmZWBMn4uOWGxkRDuZqAqCRjiroDTDjJnNfiiV8RewdDQv/CJ1xReHDoadOZDUlNepnvD6V8wq4+YnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJeb5wgG9fkp71vxIHavmL0PZG4X9fHwk8pGDbFay38=;
 b=WKGfJEmh1vM3eM8ACPH3j1E6qbVyvko5Qt24bVQirPF1LMyf0DF2vrJoUjYED/ma/qZvLMtVGj9YYhPPtFUkShcMYx1+oXUqSFyiCr5lmo4J1X24wCXJd2AsWAB7/8t10VUP6kYX2/3pDPZ3+ZgwzjtxVqEW45D/vm9yO1AAGF0M+/Q6VqxZoTbjL5pcReAl3PVcYqxvymI+6VlrA78LRFzLrif5Ppf6LuB0CfNy/rB2+0B2PJSxd5dWjrBH3n5S29LIMjTeA89aq4dB8SB+3US1VqZgNEX588sQ6ktaqlp9F2GafOztcBGhA+shUT5UIit1jHcb0OxcPhK9pfj4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TY3PR01MB11874.jpnprd01.prod.outlook.com (2603:1096:400:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 05:22:53 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::92fb:d53a:23c8:9085]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::92fb:d53a:23c8:9085%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 05:22:53 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ian Ziemba <ian.ziemba@hpe.com>
Subject: RE: [PATCH for-next v6] RDMA/rxe: Add workqueue support for tasks
Thread-Topic: [PATCH for-next v6] RDMA/rxe: Add workqueue support for tasks
Thread-Index: AQHZTT4weyrLgNABj0Occ2T7U+JCI68ONSmg
Date:   Mon, 27 Mar 2023 05:22:53 +0000
Message-ID: <TYCPR01MB8455A2D0B3303FD90B3BB6F1E58B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230302193533.6174-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230302193533.6174-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 5699bec16ebf48d794f98aeb6bb6613e
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-03-27T05:22:49Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=08c8db31-5e3d-46bf-be20-83e6084ffb0d;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TY3PR01MB11874:EE_
x-ms-office365-filtering-correlation-id: 8c350785-90c2-4480-316e-08db2e83509b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8liKKe/a5yonu7bnBP05ddgxKXzfbw1tWstSiVNcgFDDSnhfdpoAEHHQb/UWdBSNpj0MQtA9aizW74cKlpqMbclBx+nVw4CTe3yYcb4kuOqwPDqODuIDInXCnBU9EDlj085vb8sdMOR6WlfnrDFrHUZZjbWEYxvtCx1pXupltSiXLsJ8PE0fCFRzAmxhF7UX4ryhVjgcHmJ2ld+0C/W1Epw02IGnQzdQARXrc0xkPtEdXsAa4pXXJLWFxBAFIfqJbLMZFnn+LrxEZDq9EiJic45bwAxQKK+bK2RXlgsUHtZRw/EQJYZOUrvUzca+g5AqS2IuronPJetvXxQ4Vbc9HQP95mxyYszBe0oIy0Ns5+rPq60r2FtZ7WuPVMDkk2vwWXf+LgwVNsF4rWYcMPwuG8OjOMqkqYWL40QYfV+SAFYfPjlEjcz8HkBafK5Yg7TD+QUktl1TAy5ZlRl1WMfFjVptzdGKEEN16uxZy8m+CU5sT4xykBfBb015hscXruMl/JwP0YtOeiDz0QiSKBtHKs9YSxBE96AegP4Z5XxzDMfAnRIl8q8YUXZUyGEXdMxQ/XAQk+VvbOYCz0q0+psPVVgGVKX6Vwh0dlp3BbUoqq8JDmP5cMjxSO2bBPaehKf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(1590799018)(451199021)(1580799015)(83380400001)(41300700001)(52536014)(85182001)(33656002)(86362001)(5660300002)(38100700002)(82960400001)(8936002)(122000001)(966005)(45080400002)(478600001)(7696005)(71200400001)(76116006)(66556008)(64756008)(8676002)(66946007)(4326008)(66476007)(66446008)(2906002)(55016003)(38070700005)(186003)(6506007)(53546011)(9686003)(26005)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RkZ4MzI1NVFhQ2pqYWFqcU1CUU95MnZabGpMeUd0em83YjYrQU1sbjJi?=
 =?iso-2022-jp?B?ZGs0dHhMK2x3N25qU0wxZVQ3TEVORGdvYTdvZVRSVXdtWmlKSkZ3dWZq?=
 =?iso-2022-jp?B?ZGo3M0RDYlc1alZaRUpkSGVyc2xZbk5JTnp4ZVJZMVhYcVYxVnVJMERF?=
 =?iso-2022-jp?B?MWtBNnd3MFBzZllTRTdRTlErdU9XbDE3aTYvcnlmVm0yYURmNEsyWDFE?=
 =?iso-2022-jp?B?UW10d1h0MDdEUkE4UmUxY3lNWUpFMFJwdEt3QmFBSnZsQ2d2bmg2YURw?=
 =?iso-2022-jp?B?YkNFQVFSOWk3ajlyLzJ1cE5wQ3VlWmlYYU05eWs5NGsvOFdTYStiamhq?=
 =?iso-2022-jp?B?VGQwNHFxb04yclIrMXRlZERRWWkrYUdwQlpXR3BnMWpvM3N0TGVzZUF3?=
 =?iso-2022-jp?B?Sk8wRHRIOTVpY0VaY3pJTjZ3cHRiZ3Z6SzRPamw1VDZ4RGN3aVJjaC9t?=
 =?iso-2022-jp?B?WUZuQnVoRUwrQWplSXNzWTA1UjJBdlQ3czc3eUlGczBnNElxVVRadEdR?=
 =?iso-2022-jp?B?ZlhKYi9kWGh1SUx1LzJ6NTdLQlI2R3NPNlg4S2RWendGV0dhYXQySXZ6?=
 =?iso-2022-jp?B?Y3pJYzBwblVUb2xQR0MzUGNBQkhlanBaNTNvSG9LWGcrckl1RFdBYXo5?=
 =?iso-2022-jp?B?KzhtYkYvUUZHYUo4TGo4a1ZtRmNmMDBoWU42VUxKSVlDWGZRamRJZFE0?=
 =?iso-2022-jp?B?cmpKTzlmeDNxZEZ0bXQxMzl5VmswZzdteVN3aTlXVURlVGo4cjZmbXhj?=
 =?iso-2022-jp?B?dHRnUmNxVzYzYjNSSzg5Q0Z5VUFjZkFzcm5KS0lkcE1kWFRSMDNVU2FS?=
 =?iso-2022-jp?B?MVZWeXJXaWZWSThadzJXU1JvajBFeXBJdUNFaHEwL3hqY0lhYWRmT0hk?=
 =?iso-2022-jp?B?RzZ3Q1N1WlhiYlhIdlNCU2gyR0hFVkFkZkFqUTNMaVRuZDNRK3dTVlVG?=
 =?iso-2022-jp?B?OUh0ZmhiRU54NXRCYUIyRXRFZnhSTFNlSEIzOENoS3NiMlZRTE1vRHhS?=
 =?iso-2022-jp?B?KzlNWlJGUzlvb2Iva2tla2czNVVRL3o4VkVpSDgrMGRMMi8xYW44VEho?=
 =?iso-2022-jp?B?WUU2Q1BSSUtlNUZVODBTbVdjVEp0ZzVrTk9SVHZ1UVdRNmhyRWYvVE5O?=
 =?iso-2022-jp?B?a0k3MjFvOWV6YVFNUTMzV0E4cGpZWkswMU5XdlRtR1k0R0RueC95UkZE?=
 =?iso-2022-jp?B?K2xhWFRPYnRwaHZHSlBmQ3gzejM3M0V6bEFhUE5mWmZpcG5NVWFlSjl4?=
 =?iso-2022-jp?B?RVZ3UDVWREt6aDNsc29mZzV0TWYwWVVHRmdhS1hpdms2ZVdWZTFpK3F2?=
 =?iso-2022-jp?B?TURIc1RKUGtsQnJNbUdVR0F1Q3o5WDV5ZGoxeVRvZDJ0aXNKSEdDT1pm?=
 =?iso-2022-jp?B?cVR1bTdNQW9zdGZXQ0RUbGw0Sng0UkxkV2RPcWFPbENxQ0pWekw3UEFG?=
 =?iso-2022-jp?B?cC9SSmZ0eVNMcmtXZm1WZmc5ZWFZZ2orTWZ0WmJ3NFBxWCtrQVBjWlJt?=
 =?iso-2022-jp?B?ZXlxN01vQ1M1ZGwwUnhkdUgwc3FGaGU3V24yVU5DZVdPOFFxZmFnWHQx?=
 =?iso-2022-jp?B?ajBjN1JUdGZ2NldTeGtPSWozVFhpbDFYbHZlM2lRZWZRZHV3L1lKMVRu?=
 =?iso-2022-jp?B?RGVUZmVQYisrRmRNYjNBeGdMZFlMM1pySlZ6T2RBa2xjeXppWWdCajR6?=
 =?iso-2022-jp?B?b3JHVytnUnM0MU9WYlg4c1BuN1o2bHk5d0NRbXI5NkYwTFhtaEVGT0kw?=
 =?iso-2022-jp?B?NHhnV2V6aU5LQnh4NmF1WW93NEhuWC9reEZIL0RFVnZINHh4SlBjVnE2?=
 =?iso-2022-jp?B?dlZaZzk0WGk3b3VBUFFUaVRTc1ZYYVJ1NEZZZmx6WW9ialM5ZlZLNFho?=
 =?iso-2022-jp?B?d1NTeFk0M2M2S2tDNXNmYkNmbTJFcTlxTEVnTHdDUmVtWjhialpYcDdT?=
 =?iso-2022-jp?B?bzFiTEtIRzJxTVJMNFF0Q3RUeFFHR0ltb1RHc2VNQmttcE9vWlBseWNX?=
 =?iso-2022-jp?B?cVBVR1FBSWs5Q2N0cXZZS3N3SlNtcFZzRlR4QmRKeCsxQkNuRE5PWXFt?=
 =?iso-2022-jp?B?UE5HZDFuZG04NnI4cHhGWXFBQ3pOZFUrVWxudVpIekpFVHB6dCs3TXNG?=
 =?iso-2022-jp?B?R3RYRFJINHU4NUtrT21XV0ltd2RONzNCZUxEYkw1NHpqelFUTE15bmNi?=
 =?iso-2022-jp?B?MzduNmorTE5zZzR5bXFwejZoVzlzTjgveXlCMVdCKys5clZQa3JGME1Z?=
 =?iso-2022-jp?B?T1RyZHl4SzVQUThnWU42Mmg2aHo5WVp2czh0b1l3WVY3WWRPZWJ0ZU5L?=
 =?iso-2022-jp?B?SFhZSEY1a3JpVFZ1TjA0dkhQcDBIQ2xBc0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rWdCVjwfqR2L8GtyaNAHQB33tYiiMacNP/mIQ/UjB6z1uWobGSiTMgQxAscB/ExR9zT0Ndhf0udXJ0jG9eIitoOm9zNF7uYHbsFUENjRdqkP/38xYwmxM7akQB7q6fm9GSzdSrYLJ31+yeQhXgjWfAi+ild/TVI1uhoGlLA+luV9ggVmsaeATMCQqwY3g7bL86bFfxuJ4ZgkYnawf9rSpTKd5X6xrvIcs4Cqrd3pVwA+GiXLGSGV00z2cMPvsHWVr0QrnyTXkhq/m06z0tZtrVXq+erDSpMbLXa0/g1QaTah7RbGT4mI3O0aR4zKD1HXeuejzUIXv4Wvhz4Lfd9XJGdNePy9apeKEK/JjlpJsAM9/KeDHMRpCBFgFZ8mo9gPNIlFcdlbTeWyGMNwBSXHSwE3An32FHBmq+8R5P9g0+wfVScGH/jg+zkCtss4TOF/J8wWxooAcmxk5aSSxKt8OkMdVpq+zC8a+5ZqGE+mf5Pkhrw22Aw1QLVXaiibafZa+9mqDuXx/Yxori1kpNSRK9tpifAIgCImuwzyMMOOEKPClhdwBxIH//BeZwqfec3wiCu4PkkBvJ5/0hopaeBNjRBmYylb4ASKdSBy8eE0JFpXZ9djxPfHLiyeBjFg9h/+bgBEcRvylX4RpGTdSc0eUETtrHerGu5z+x8hkA9GjDtn5JydHaHNgNnWz1bHmfZzH6qjFeyD0IA5+t5dieTNe48TueUbkoX/QZ3ea1U4ZFlEcv5QSGJa64v5PPUiYZKbecodjGaEcllm+Q427RS+0FYr1D0OAZkq3tFtQMJBY0kFwqxOhr2W5Yl2x0qN6dkI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c350785-90c2-4480-316e-08db2e83509b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 05:22:53.0842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbvKXMT9tQBOiSZwDf0ngfA9IXgZE2uV6KjBaOF1svCSl27E8nsGiED30rnfLu3gcF6IGFoqiLkT5I3tjk1NY9JbUfkm0ZpnBmiTA3Rt0IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11874
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Fri, Mar 3, 2023 4:36 AM Bob Pearson wrote:
>=20
> Replace tasklets by work queues for the three main rxe tasklets:
> rxe_requester, rxe_completer and rxe_responder.
>=20
> This patch is all that is left from an earlier patch series that also
> converted tasklets to workqueues with the same subject.
>=20
> With this patch the rxe driver does not exhibit the soft lockups
> reported by Daisuke Matsuda in the link below.
>=20
> This patch depends on an earlier patch series titled "RDMA/rxe: Correct
> qp reference counting" which corrects the same errors for the current
> tasklet version.

Isn't it better to add the link to the patch series for easier reference?

>=20
> Link:
> https://lore.kernel.org/linux-rdma/TYCPR01MB845522FD536170D75068DD41E5099=
@TYCPR01MB8455.jpnprd01.prod.
> outlook.com/
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v6:
>   Fixed left over references to tasklets in the comments.
>   Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
>   a significant performance improvement.
> v5:
>   Based on corrected task logic for tasklets and simplified to only
>   convert from tasklets to workqueues and not provide a flexible
>   interface.
>=20
>  drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
>  drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_task.h |  9 ++-
>  3 files changed, 69 insertions(+), 33 deletions(-)
>=20

<...>

> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw=
/rxe/rxe_task.h
> index facb7c8e3729..4e937de9ebcf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -22,23 +22,28 @@ enum {
>   * called again.
>   */
>  struct rxe_task {
> -	struct tasklet_struct	tasklet;
> +	struct work_struct	work;
>  	int			state;
>  	spinlock_t		lock;
>  	struct rxe_qp		*qp;
> +	const char		*name;
>  	int			(*func)(struct rxe_qp *qp);
>  	int			ret;
>  	long			num_sched;
>  	long			num_done;
>  };

The member '*name' is newly added here but not used elsewhere.
It seems we should just remove it.

>=20
> +int rxe_alloc_wq(void);
> +
> +void rxe_destroy_wq(void);
> +
>  /*
>   * init rxe_task structure
>   *	qp  =3D> parameter to pass to func
>   *	func =3D> function to call until it returns !=3D 0
>   */
>  int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
> -		  int (*func)(struct rxe_qp *));
> +		  int (*func)(struct rxe_qp *), const char *name);

This does not matches with the function definition. Kernel build
fails here unless the 4th argument is removed. Additionally, the argument
"*name" is not used in rxe_init_task().

Thanks,
Daisuke

>=20
>  /* cleanup task */
>  void rxe_cleanup_task(struct rxe_task *task);
>=20
> base-commit: 6a22f7fbde87336002886583d053bfa1cd8ff1d1
> --
> 2.37.2

