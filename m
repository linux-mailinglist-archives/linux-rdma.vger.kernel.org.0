Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C797D2930
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 05:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJWDwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWDwc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 23:52:32 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D98ED
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698033149; x=1729569149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZtPoUSYixU62ubGrHPR6ooZ4wAxhSaES5tWDSMa9RFM=;
  b=W5lO6u/sWdOFHisMo2+c0SvDXCXJwUfz3uXO+sMJf5aqBEBr4L3v+KFy
   mzC6VHd7TyAEAUHB6VL6VZC3MFuZBpKkYxP9mX3rH2wwhK5LLU+o6YTpz
   iiIwIqpHyLSdu3ySDVZAuENOlpVXyOK38RzWc3P5ErSBl2ZK2J/A3n0yp
   12B7OpOUk73x0fSa4O0XHEAsXae6zAa0x94wkBB35DIZGxL1Zvg1UDcDV
   /YquqTEr+L/bgz8j0lVZh6wtE93twfWjW0eMTzr6Ht+65msiDpg5WfmVZ
   1FMSJMOYTw7sP95i+8kl/NtgCAjkSmsTlq05t6DZB3A7AsUER25HkQOFQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="100312089"
X-IronPort-AV: E=Sophos;i="6.03,244,1694703600"; 
   d="scan'208";a="100312089"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 12:52:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZMHZ+4U+26dhhytMCkIUi78Ff0L/GgniIddfnmeMGevvSRDul7BNea+cR6tdNGRp+meHYvjHvvgHtNNodAQHiIQTiesB2MG59FLoQsje7htmXASSusqD5F8uMhMR5ishfUkDw5pPAcjBj/0euaRnUQvM5kXpk7KAcW0WHjR/W0rwDj4y0aLAJo1fdRom3BsZDccR4LtptI4MeEwCfJnFKMiSLAhq6H+SiInj2PAIO540ZkF2fxCHnBSMEkbW7xnBAi7/1COqf5ryMhRfCn0FMBE24WTkf7ETk7KxYuKCv+clPAskskp9MGyTRRpN0nE6Arx+HTiY90+MALDLoFlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtPoUSYixU62ubGrHPR6ooZ4wAxhSaES5tWDSMa9RFM=;
 b=n/OZA7nLUW1CnD9kQBg0GdY8WVI+bgZJGCUZOhxghgZWZkcsDqPUzOoz4+rpxpWhKzRqCxQ6cdr4dlb/Zgb3pczJN6Xs6pzVbuIEfPxocbg3bJ1jlqpQfprOXmXCH/nb7g9eMpcOWyAvfg9zx8pa/XDKJUQemt5XVUSIHnYR0uj6yX2c5Dif0t06+U5bHw2Kt9S53AdtlxkaBzF0CgyoQ8qOG6Qafdc7wtbf/kxbJqylxcpl1ESmcSzuo4p/rT2A2kg9Rd7LHoZXu7Yo4tx+1kBAbD1nETLSso5A4IPHP8BBKalf8rkN/GmClCDlvfoX1Hjg0Zi+Ghji9w0LFCr5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB10086.jpnprd01.prod.outlook.com (2603:1096:400:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 03:52:22 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 03:52:21 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoCAAKu4gIAEDL+A
Date:   Mon, 23 Oct 2023 03:52:20 +0000
Message-ID: <6c57cf0d-c7a7-4aac-9eb2-d8bb1d832232@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
 <20231020140139.GF691768@ziepe.ca>
In-Reply-To: <20231020140139.GF691768@ziepe.ca>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB10086:EE_
x-ms-office365-filtering-correlation-id: be967666-6b8e-4840-0c55-08dbd37b7569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIzJFbU1j956aPieBa4dBN6shL4STSq/1OWMU6XgrLVkOKl7t/aNSLAC23OX0lwne/Bz9d23B0UOc8FkCMxFMs38JkLjFcOhUoMw2ydGmSOGaPXwvcH9i36DebWI8BxjXhcWTnWmhxCOTYBxMDdCgcJrSZxFqSbRS+VvKn5gb+vNbWRjfssNTyvMKwPXtA/DaTL55TymYyOoq7KQ5lLXQw8Ri9JN1vBGCvBUayLiuK5YQylTmLM2ggFonj4RltkbCCso8AUzyd33nTNsI36mj6Or5UpjpjAqR2oMvyMe71qiJrn9R7CwuX27JBW34pujSwG1ptZqWz6BNvkjG3jMiEbQ2LbNWojoMcx9TGHL3uIcG+9upgbdmHWl+YVjrhEmB9XvVbIn8ncSBB7C9aqOz9Dph2U68qWmd2YfSo9MsW2gzvZNSvqPVzh4xfSk95ckaCte5z5qKE0ZD+jrDkaccsl2wD5tq0eEMToiVibWFv16pIAHo1TBrV7rz5VQAi3KdFdDau3VllunLQG1hjntxbyr/z5/5Nuv/2OsIDYlIhRboJMQNZLjYO9hr6CLMglF3xJyY84hmxSvRgfgUAADBDueNgwJxhuDmOm6vUsf9bbTxBkojqveMvcTGpxHLCVGLgGYZSDomRDOh2TT0fI7jo3V57euRa+Dkbe512QBsYsLOukjAJYkvc8cvpEpN02oKU2PBhYq2q7m6V5DXxRdmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799009)(1590799021)(186009)(64100799003)(451199024)(38070700009)(31686004)(66899024)(1580799018)(26005)(6512007)(53546011)(86362001)(31696002)(36756003)(85182001)(38100700002)(82960400001)(122000001)(83380400001)(2906002)(478600001)(6506007)(966005)(45080400002)(2616005)(6486002)(71200400001)(8936002)(4326008)(316002)(6916009)(8676002)(76116006)(64756008)(41300700001)(66446008)(66556008)(54906003)(66946007)(66476007)(91956017)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1ExTmRBOUxid0hvT0xQVm5Id0U5NE9LM2hTYUFNSmZPRGRUTExqMU9OV0lj?=
 =?utf-8?B?V2lSRUhmT0c1RjdHcmlob21VdEJXM0hLOVpLT0IxZGdOam8rSXgySVZIdy9y?=
 =?utf-8?B?K2J4SnhGRWMxRWpzRjdHVENUcklBajI5blhFdjNNT0duMnM3ZUV0SlBWMWN3?=
 =?utf-8?B?aWlqRXk5K2FxSkRUUk4rb2NMaUlaRkg3ZXZVRlIxdHpVZmVzdEVocnRQYytG?=
 =?utf-8?B?UFkxT3IwcmJRa2JlMkU4amNQTWhlaVNCclhaRjJ2M2dkVkczZUtoTlMraUNJ?=
 =?utf-8?B?cDV2d0hrR1pZcXlCM0hVOFBhQ1k1Z2J0RGRTdFI5QUZCT3pNaE9vSXlQb3Nl?=
 =?utf-8?B?L2I0VDlCa0NpeFBvUXBjeGtrUit6dktBSTFpOCtySmxHMDRKc0ZQQTJhVWI2?=
 =?utf-8?B?Q0F6NnVObGJtRGM5S0ZJSGp6eEpydE9EMndWTEZmSjZEM0RZOGlvQkxyUVFJ?=
 =?utf-8?B?WnJXMFl3OXN4Z08zekZjOFdGeWI5MzdqeVdJTHl4YjlYS3NoNVdobjArejA3?=
 =?utf-8?B?RDgzZzJtWGtoSXgrKy9KUDc5eDdDYk45aCtiMXMya3BlWmNva1QrSGNYclJ2?=
 =?utf-8?B?N0xxcE1xUmw5L1g2ai83eEN2MEpPZE1zUDI0LzVXNFRTVzcvdGJuZ3NBMzJt?=
 =?utf-8?B?T05ZbGlvd3BhSE5oSjBJeGhkTWlkY2NGZnJHdjhxZVJYbnA5WER5aExjeWxW?=
 =?utf-8?B?L0tpbWVzS3djc1dwTWFGVVJGL1lYYVFncER1Vm5TSDduVmxXZ1lKVjFDV2Jq?=
 =?utf-8?B?anNHOTh6Y09reWhEVzNkOGgxMFJ6a0lGcVJkZlUzNzg3WTEzSFhLaDdENlpo?=
 =?utf-8?B?ZWg5d3hpTFlWeHdMNUlBVFFnWUMzVkQ1VkttSFVmQVVWSzBhcEl1ZTNDUDBR?=
 =?utf-8?B?THJVQW1XTjNOOGk3MnBIeDN1TlE5Ritrc0p2VVY5ZzlQa2xTK092T3dEOFRN?=
 =?utf-8?B?TVJUQlZmZnEvSGRTKzIvRDFJTExsMyt3RlhOd0hDM21xSU53Z0VJVXJrOTly?=
 =?utf-8?B?c0N4SXVzY2QxbFB6cjMyRVE1VkpWRnV6Sm5Oa2NPbVZKcnQwUjM5VG9rb1Nw?=
 =?utf-8?B?aytFRkRwd0xFd3NwME9lM3F5N0FPellKOTlqQzAyeW9aelNaWkdoVzg1N0hH?=
 =?utf-8?B?bTZ4a0pUMkxESHE2SG82RVk0ZzczOW5wNThzR0JwbkNSVGNxK1Q2c1NUaWpV?=
 =?utf-8?B?QWxJVGNZdEtDSzlmTVZyQkR1R2s1eG40UjVQTkNMM082Q1pnRzZQNGVoK2Fk?=
 =?utf-8?B?QitKYVdwN2ZPYjZzdUtSeG5ud0VvWEVPVVZJdE1XVVFWbS9SMjlSbkpTVkto?=
 =?utf-8?B?N3hIMnVKY2U5dXQyTTRYSm41d2d1SGUvTGxMRDdsUmlhNzFMMUlDaFVhei9z?=
 =?utf-8?B?N2lBOXZiSTVQTDFFOXJzWEhIdkVBdUtYRERZaGpiVkFMYVJnTjZQeDJoS0oz?=
 =?utf-8?B?U1FMM2dCbjVNZGxtbjc2UGo1L1lscmM4VVZrUFZSa2lNaWlOdGR3bXVBcTZp?=
 =?utf-8?B?enBReU8yM3lxcmE5THNpWkNZSGM4eVAyc3VWeEJYMGYvOXNZY0VhTjBKdDlJ?=
 =?utf-8?B?RFhBaTUycFBCZEVQZEdJY3pEeXRrS2VOQ3p3d0VkTnBVcnNmd01FWFhCLzZ5?=
 =?utf-8?B?QjU4d2l3a0xWejZBUnJxcmJhS3dZM3VqeUEzN3RKaWpsNTZBOU5wbmIyQ2hN?=
 =?utf-8?B?a0pDZVpjR0d5RVdSYzNzbkNRL2pFeHRHNXE1TkJPMDluWFhZNGZ5K3dSL0w4?=
 =?utf-8?B?K0o2bVhFL0dmUmZJeXYyTjl3UmNLV3FGY09aeDc2ai9uUmVLYUxZOXU4NVVh?=
 =?utf-8?B?NUw4c3B5cVhCQmVKRUkxRkg0RUdoa3lCbHFtUHp2ckltQmU2QUFta0F0cElj?=
 =?utf-8?B?OWN6cUZyMi84Q2NxZ015Wkt1Tm5DMUcreHMwTmFnTlhYTlpMNys3em9pTHVv?=
 =?utf-8?B?UEwzejVOODd0NjROenFNOTdWY0dqWlUrR2hLODJKSmY3akNhVlA0akJZQnVa?=
 =?utf-8?B?blZOd0FOMUtURzhTQ1RWelVqZnRaRXdvSE1EcDVpN2VyWHkwNkxPM2RERkFF?=
 =?utf-8?B?L3JRd0dLMVFicEtiMW85RTdIcHB0dExsdThaTSt4dGRmdE5OUER6NkRpVUdX?=
 =?utf-8?B?cnlMS203TktGaUhmcmtVV0g3OXFMT3k1NzdvRzdSblpmdzMxNmd1eXJEQXM2?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F309C8C996A6848A44E10854FF941FE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Tzhzck1Yc0tpYXBmVWNvRmpQcjAwTGRzd2JrZVpEYjVYY0Fkd1IzVkZTeENi?=
 =?utf-8?B?NGJyWmhtOGp2UFY0a2FOdkg4WGVDN3FLQVhQSGM4RmUwRVhkNHNkQ2VUOUlZ?=
 =?utf-8?B?SnBFc2hxYUNORG00L1VTb29aM0g0VXN4YUc0YWlZR3BCenRYOXZLTDVucU5H?=
 =?utf-8?B?a2R2NFRmOTJMcENwbjcvM3Y3Z1FLeEdZVFMvbnJCWjZEVDBBNDNoQ0t3N2Yz?=
 =?utf-8?B?bzV4cU54ODJZR2I1MFU1TERXb215ckhKS0p5eTNnNmxVd3J1SUlYVnpaVi9n?=
 =?utf-8?B?clB4SmJ1aDdiQjdENUgveTcxOFZTQ0thRlhJVm80UXZ2U2lkdUd1YzFvcmpH?=
 =?utf-8?B?K2szTU9PQnJvVFZqUHhwcHk4TWVtdjJhZlNOVkFkRVo0RExhbng4bFMxVkM2?=
 =?utf-8?B?ZjFTenZWZFhzRHdNNzBoc2cvdkVHUWdKVU5ORnZrckFrZnVkejZGdjg1ZDdu?=
 =?utf-8?B?elI4Q2JWS1FXRTJOZE40dm13MUF1VmhWOXA1ekVGRDE3RHpSM2hUelp4VzNw?=
 =?utf-8?B?QlpPQXg5aTNJZ1h1b2NySmdmK2JCblVqQ0gyWXgvMjhTUXhTNjJvVDVITW5B?=
 =?utf-8?B?UGJGWm8ydTNqY2tSRWM1OXFvK1JYQ0dOTVUyTnhjMFdYVnpkaS9qOXNoeUNv?=
 =?utf-8?B?TjA5ZUtEOFFHamdibzcxNll4eVdldGhzM0JueWlWbEM2UEhWMXdpZnNLNndN?=
 =?utf-8?B?aGQ3SitSMkVsQm9Jek5hUHhLL2hTWUw0cWlublI1ZjJaQnYwT2RnRnBrVnhu?=
 =?utf-8?B?Z0ZVNVFjWFNHRU95Z29XOG1pN3RiU1h0bWoyM3pJYXY4MG0rWUFxNForRGRT?=
 =?utf-8?B?dzhMOGUvZVJZRjVXSnEzUnpJZXZZRDlJK3RweTFQd1ZIYTFoSDlKSFZjMWFB?=
 =?utf-8?B?SmNSWVI3RUx5OHZ0RTRvR1ZkdzhZWEl2M29BV2xadmZWY3N2Z3BYWFM0WW5o?=
 =?utf-8?B?TFl1MCtrOG1tRkduREM1a1NwT2ZqS3l2N3VLL3ZSd3NnaERvZXVENk9teEdB?=
 =?utf-8?B?dk1SWEtzenY0Ukxscm52YWRHUlNvcDdvMDRqMU52elJyUjZoODlTRFJONE1y?=
 =?utf-8?B?a0ZVa1lEVlFFR2ltVU1Lc1JSUHoxYmMrdzRLa0tGQjFRdU45N0d6RmFyaEh5?=
 =?utf-8?B?OXNSbE9XUUpoL3g1N20wNDFRZEFSU3NTeVVWamFFRjdFV0Ird2piNnJCaUhH?=
 =?utf-8?B?VUMzQzY5bm1MS0hoVkNMYjI1TVR5dlpoWW5VNVVOUW1oNUgrTTRHZ2VjMndP?=
 =?utf-8?B?ZGlYWnVPWW5iQk5IbGV1ZGxMZWx4d2t3eWlKYmlXUXVCQlR5Zz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be967666-6b8e-4840-0c55-08dbd37b7569
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 03:52:20.6814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: do90Ar3OAj1LCQXPp+cugW5g53UJgMiSA/Kj1eYn/JTu8Ncfl5XRqp7MI/6LvfIAkYLcGW7RgvgyniUnpar/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIwLzEwLzIwMjMgMjI6MDEsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gRnJp
LCBPY3QgMjAsIDIwMjMgYXQgMDM6NDc6MDVBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+PiBDQyBCYXJ0DQo+Pg0KPj4gT24gMTMvMTAvMjAyMyAyMDowMSwgRGFpc3VrZSBN
YXRzdWRhIChGdWppdHN1KSB3cm90ZToNCj4+PiBPbiBGcmksIE9jdCAxMywgMjAyMyAxMDoxOCBB
TSBaaHUgWWFuanVuIHdyb3RlOg0KPj4+PiBGcm9tOiBaaHUgWWFuanVuPHlhbmp1bi56aHVAbGlu
dXguZGV2Pg0KPj4+Pg0KPj4+PiBUaGUgcGFnZV9zaXplIG9mIG1yIGlzIHNldCBpbiBpbmZpbmli
YW5kIGNvcmUgb3JpZ2luYWxseS4gSW4gdGhlIGNvbW1pdA0KPj4+PiAzMjVhN2ViODUxOTkgKCJS
RE1BL3J4ZTogQ2xlYW51cCBwYWdlIHZhcmlhYmxlcyBpbiByeGVfbXIuYyIpLCB0aGUNCj4+Pj4g
cGFnZV9zaXplIGlzIGFsc28gc2V0LiBTb21ldGltZSB0aGlzIHdpbGwgY2F1c2UgY29uZmxpY3Qu
DQo+Pj4gSSBhcHByZWNpYXRlIHlvdXIgcHJvbXB0IGFjdGlvbiwgYnV0IEkgZG8gbm90IHRoaW5r
IHRoaXMgY29tbWl0IGRlYWxzIHdpdGgNCj4+PiB0aGUgcm9vdCBjYXVzZS4gSSBhZ3JlZSB0aGF0
IHRoZSBwcm9ibGVtIGxpZXMgaW4gcnhlIGRyaXZlciwgYnV0IHdoYXQgaXMgd3JvbmcNCj4+PiB3
aXRoIGFzc2lnbmluZyBhY3R1YWwgcGFnZSBzaXplIHRvIGlibXIucGFnZV9zaXplPw0KPj4+DQo+
Pj4gSU1PLCB0aGUgcHJvYmxlbSBjb21lcyBmcm9tIHRoZSBkZXZpY2UgYXR0cmlidXRlIG9mIHJ4
ZSBkcml2ZXIsIHdoaWNoIGlzIHVzZWQNCj4+PiBpbiB1bHAvc3JwIGxheWVyIHRvIGNhbGN1bGF0
ZSB0aGUgcGFnZV9zaXplLg0KPj4+ID09PT09DQo+Pj4gc3RhdGljIGludCBzcnBfYWRkX29uZShz
dHJ1Y3QgaWJfZGV2aWNlICpkZXZpY2UpDQo+Pj4gew0KPj4+ICAgICAgICAgICBzdHJ1Y3Qgc3Jw
X2RldmljZSAqc3JwX2RldjsNCj4+PiAgICAgICAgICAgc3RydWN0IGliX2RldmljZV9hdHRyICph
dHRyID0gJmRldmljZS0+YXR0cnM7DQo+Pj4gPC4uLj4NCj4+PiAgICAgICAgICAgLyoNCj4+PiAg
ICAgICAgICAgICogVXNlIHRoZSBzbWFsbGVzdCBwYWdlIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBI
Q0EsIGRvd24gdG8gYQ0KPj4+ICAgICAgICAgICAgKiBtaW5pbXVtIG9mIDQwOTYgYnl0ZXMuIFdl
J3JlIHVubGlrZWx5IHRvIGJ1aWxkIGxhcmdlIHNnbGlzdHMNCj4+PiAgICAgICAgICAgICogb3V0
IG9mIHNtYWxsZXIgZW50cmllcy4NCj4+PiAgICAgICAgICAgICovDQo+Pj4gICAgICAgICAgIG1y
X3BhZ2Vfc2hpZnQgICAgICAgICAgID0gbWF4KDEyLCBmZnMoYXR0ci0+cGFnZV9zaXplX2NhcCkg
LSAxKTsNCj4+DQo+Pg0KPj4gWW91IGxpZ2h0IG1lIHVwLg0KPj4gUlhFIHByb3ZpZGVzIGF0dHIu
cGFnZV9zaXplX2NhcChSWEVfUEFHRV9TSVpFX0NBUCkgd2hpY2ggbWVhbnMgaXQgY2FuIHN1cHBv
cnQgNEstMkcgcGFnZSBzaXplDQo+IA0KPiBUaGF0IGRvZXNuJ3Qgc2VlbSByaWdodCBldmVuIGlu
IGNvbmNlcHQuPiANCj4gSSB0aGluayB0aGUgbXVsdGktc2l6ZSBzdXBwb3J0IGluIHRoZSBuZXcg
eGFycmF5IGNvZGUgZG9lcyBub3Qgd29yaw0KPiByaWdodCwganVzdCBsb29raW5nIGF0IGl0IG1h
a2VzIG1lIHRoaW5rIGl0IGRvZXMgbm90IHdvcmsgcmlnaHQuIEl0DQo+IGxvb2tzIGxpa2UgaXQg
Y2FuIGRvIGxlc3MgdGhhbiBQQUdFX1NJWkUgYnV0IG1vcmUgdGhhbiBQQUdFX1NJWkUgd2lsbA0K
PiBleHBsb2RlIGJlY2F1c2Uga21hcF9sb2NhbF9wYWdlKCkgZG9lcyBvbmx5IDRLLg0KPiANCj4g
SWYgUlhFX1BBR0VfU0laRV9DQVAgPT0gUEFHRV9TSVpFICB3aWxsIGV2ZXJ5dGhpbmcgd29yaz8N
Cj4gDQoNClllYWgsIHRoaXMgc2hvdWxkIHdvcmsoZXZlbiB0aG91Z2ggaSBvbmx5IHZlcmlmaWVk
IGhhcmRjb2RpbmcgbXJfcGFnZV9zaGlmdCB0byBQQUdFX1NISUZUKS4NCg0KPj4+IGltcG9ydCBj
dHlwZXMNCj4+PiBsaWJjID0gY3R5cGVzLmNkbGwuTG9hZExpYnJhcnkoJ2xpYmMuc28uNicpDQo+
Pj4gaGV4KDY1NTM2KQ0KJzB4MTAwMDAnDQo+Pj4gbGliYy5mZnMoMHgxMDAwMCkgLSAxDQoxNg0K
Pj4+IDEgPDwgMTYNCjY1NTM2DQoNCnNvDQptcl9wYWdlX3NoaWZ0ID0gbWF4KDEyLCBmZnMoYXR0
ci0+cGFnZV9zaXplX2NhcCkgLSAxKSA9IG1heCgxMiwgMTYpID0gMTY7DQoNCg0KU28gSSB0aGlu
ayBEYWlzdWtlJ3MgcGF0Y2ggc2hvdWxkIHdvcmsgYXMgd2VsbC4NCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtcmRtYS9PUzNQUjAxTUI5ODY1MkIyRUMyRTg1REFFQzZEREU0ODRFNUQy
QUBPUzNQUjAxTUI5ODY1LmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vVC8jbWQxMzMwNjA0MTRm
MGJhNmEzZGJhZjdiNGFkMjM3NGM4YTM0N2NmZDENCg0KDQo+IEphc29u
