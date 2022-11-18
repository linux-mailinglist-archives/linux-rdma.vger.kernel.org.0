Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E262EAF7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 02:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiKRBdd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 20:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240913AbiKRBc7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 20:32:59 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC584898CF;
        Thu, 17 Nov 2022 17:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668735166; x=1700271166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IYK8UDA4ZK7R2oKVI0nJNVmvyW8J5zomDc81GqVx1uU=;
  b=d0hXZgKM/ckQ5olDvLCV2pSlr7mF3bSxLrpFHnWng37Uoy7cWYgiQ/ok
   AxAhfs2ND8T4qoxs4JQNn0CqHcm9j/zfb3oxafhEGegWGPqgUraAlwCSo
   2GKGl67c2R2uS3Kw8hIhqJfhOpPGa6Ve+b/1gTuYrf4BxLuj/pSBomyKr
   7I/uMAkfdcl1SbG6G0zPQupM6JmD2NRUZ4Jb3ujel2iLnkt/ABuix9CWk
   ViLc96rIyB9AMR+eEqTpbmsaf4yUbAlpZy4SyJ2roSAW8it1fmA6GgN0i
   ROWCabZ1VkkBiGgIevB8sSerHZ/YcAB6+d3bM4ZUpP59Yy+SCfsgFoIRL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="70367239"
X-IronPort-AV: E=Sophos;i="5.96,172,1665414000"; 
   d="scan'208";a="70367239"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:32:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjmrX3Wqf9VsIcz8hadKme3lqhhiDJ66N736TDaXYoqKqZprnBSOneZLDfoBhk02x91jjg85/kM5f8O7hryVh8wW+cwN5jBxyHkJWER+LVuLCsS1weKObhCaefjk73Cernabn9maaEyZH3WkptSgj0N+QX9FKvCTg1HJzSGui1xiSio72YB+RMp3r3PRD0UmWKn0zXvID0pGMrM6iWCK4rHfARXOUtGyzzG0Wx/6vfw6FYgY/bRYlKf7ZrbG86jdpfFme5zufz6NHhC68H+Uqh+Lk0UN9JcmoFngSo75MI1ysJrPNArUXoJQrqWVCoV2/EqNbe0u/u3xfJNTaGophw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYK8UDA4ZK7R2oKVI0nJNVmvyW8J5zomDc81GqVx1uU=;
 b=m4diFZ4ldB86d1IPrX+PuhLw9uutnTqnWZXsdwK8e8bnC3sZjuFXa1dR/n6De3JcKRRqo6Mvcp1255t82AOMgb2XE3BFG5+chUHT8NetP79rKxr6XMMkEUDZ8zt0eN+JOQyIl8fsV8l+pVZw94APQQhMaCb9QxbgAeMF8fy++e2BVMlLRuMKKiviuoixSwjOa58i7rDXhAaYI7Bk976a6UM8hXU249A2To2C0qhQFpPhKSGoYQ663ap2vYvx7CfWp3YzJ8dGmhnee0dTpskg9xrUEVe+d+2C9BT+4jTRtOX4ISXkmtqA8KC7t5sSpbrmspIEUS0gMg2PwhgAJwCczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB10524.jpnprd01.prod.outlook.com
 (2603:1096:400:308::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 01:32:38 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%7]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 01:32:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Thread-Topic: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Thread-Index: AQHY9YZ40HUZTU1TtU+RpkMBp0Z1vK5BhUIAgAJq9QA=
Date:   Fri, 18 Nov 2022 01:32:37 +0000
Message-ID: <b97f8d1b-3116-5677-f327-27f394eb6c89@fujitsu.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
 <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
 <CAPj211to20yHUy8o-Lg6TMjB5rpwrfPCUtQqxfeDFHUDR4+wJw@mail.gmail.com>
In-Reply-To: <CAPj211to20yHUy8o-Lg6TMjB5rpwrfPCUtQqxfeDFHUDR4+wJw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB10524:EE_
x-ms-office365-filtering-correlation-id: 5d8c1e0a-e7a1-4e11-ff71-08dac904c6dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRb1KOfbaCzgupLJwsX2dEMm1S1L5fKKjBM6zvZkGx+dQ/Qsdztn47jpk/rw9v8/pFeJd99kMgOuXYvg22OHaXd8LvAPEU2//mf1yTqc8wPRTCDzc4cOJgtgY5JvVOZ/NE+Z7RRxhlXA0KRHU6TbW9sAYBK8UfjPWewlM2buLsnxPtwPdGyIP3MdTwzasKyu9oSi4Skt1wPYgDaqRQMtiCxdl9kgIjM8zyKcxkmZdKEmNkhDPcRLHvB5NMXG15KjxLqw6AlON4yVnCUX9HFmjlbTMwom93jK6Ti0jjj99LGz0Yr25hbjPvRKEj2lFNY9NsqqEsefelNbB/MRMkwQ/BxG2+mQ6E11JtGK7xKLC/QMcpCtuD8NhSIQNC1cUPBBbshmVNURYmWEb27WQZqN9d1srLs1t72f4NdV3xwH/3xcagEL+xQU/bW051VWM7SNGAtdszAwZNUc5LUBuSeV9n5JIEbLBAfEzS5HkQ6AsWNcPdAfPgeCzsbM5nEhwcdoBAldwoNq4wClzwa3pagyzvElsTj1PD5kIgB2xVD5UAqZt23KD7G4PYyW+RxsavUzNPyhCZV1SIWC8KMh4U4u1rx3PJmUwuBTAua6i+M/2yd1I17rNO3T8V7u9PTMuqP3BARqAuH4CTrvZn9Qj9bq01dJq3/V4SmIu8mNjTYNmIqGo0GTWCgJ22dEDO1dC6xRETf97Yvg3kt8j3qqDjc9K06t9aO4/KUUMI6I1IBAKZnT390+ZS+QNVHgl3W0yzUd2aLIGvhkQYmin+WCXUSbyssgNcwTOHIrtb3iOfNGeKfXH/XPC9BMlW7O/QwRLO2I8a0EfziHai9Q3qj9uCsyHlMW8dvV7ApzPJ3PGo78IF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(1590799012)(451199015)(54906003)(31686004)(1580799009)(966005)(6486002)(6916009)(71200400001)(31696002)(478600001)(6506007)(53546011)(85182001)(66946007)(316002)(66446008)(38070700005)(64756008)(76116006)(8676002)(4326008)(186003)(36756003)(2616005)(8936002)(5660300002)(41300700001)(2906002)(66556008)(38100700002)(86362001)(82960400001)(66476007)(122000001)(26005)(91956017)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEx1TmJpbmd2Ykk3RCs4d0J1QVhTZEpnaDFoUHFJcHp3by9wTXc1SWhBbXlz?=
 =?utf-8?B?NTY2TmtIeExIVHJZUG41VEJDZkNvZHZWcHZiR282MnZZSloyL0NjVzhvZ1dK?=
 =?utf-8?B?U0EvVTA1RUxnalg1MlJtNDg1Mm1NL3hwNHZDKytXeE1IdHZpVHlsT0lpeDJE?=
 =?utf-8?B?MlFWU3ZzR2VRSDczYzdDd2puNEpLcXQyU2dLcXNqRU1pZDNsbkZPQVhNaHdV?=
 =?utf-8?B?RDVPdTdHN1pjYy9PWjYwWjk3M1JCZWRieWZwMkthTnVaNzB2alU5b0VoSDBJ?=
 =?utf-8?B?d3IyTU1FUjBqUDVsS2hjUThxVDRaQWF6MEtJOE5wT3BTa3B1cHBkMFVqb0hP?=
 =?utf-8?B?N3kxRjVkZTlyN1BKZ2h3NS80K25pYnZ3YWhFMlBqRWdyMFFhUWlrR1ZoYU1j?=
 =?utf-8?B?WlVQeklNbUIwNFhBYi91NHpuWElabEtiQitlTjUvd04ybzFGSmF6Slk5UC9r?=
 =?utf-8?B?Y2JTb3pQZnNYVXhjZFVaUHptN0pEZVRYamw2UUczUkswMWl5VXBPOUxpak1W?=
 =?utf-8?B?VzdNVWlRUnh2NzYrb3Q0TUUrRm1lNGVPVnQ1aEFYZEdRbnNWZFFlb2FwWmpI?=
 =?utf-8?B?WXZobVo4VnEwWVNtdHZKTUMzcXFjejJ5OXp2UXJOeUcreklqRlQwZ0llRUty?=
 =?utf-8?B?dUNMU01pdnRBMExWRlo1b3BiNlVOSDBVMkg0eFBiRmtzR01SeW1UbEVjY09U?=
 =?utf-8?B?b1VXNW04Um4rWHJWNnNWS2g2d1M3aXo3Ty9qQ0ZWQXNzdjh2am9CVGdzclB4?=
 =?utf-8?B?SDRGQ1lvYmNPUDRNc2YwWkFaazZrK0ZsVlpqWW1wMkxLNExwZ0tZMkZpT0R2?=
 =?utf-8?B?VmxPTHJNYUlMSVhqVGlFNjBIVS9UZEZoS3cwdTl6Uy9QNHQ5WUxWYXhNQ09L?=
 =?utf-8?B?WnpnNW1DM3ZITXh3cDRCY1NCM3RkQlVXZ1RQWkNJemhNVDZBU0lOdUVjTmdL?=
 =?utf-8?B?RFdqR0duSnc4OTQ4UThQSWt0VFFJdFRCTmVlcmtQditxZkVRdXpEWjRXTWxk?=
 =?utf-8?B?azZFbmtubjBYK1F5QmplZHJpdGVOK0JNM3Awdlczc00rYU8vWHF3WnJTc1NG?=
 =?utf-8?B?czBNRE9sZGc3OGJpMU1KZHZoNUJ1OHA3M0Z0c3Y1QTRWcHBnWEVvM1FzV0Iz?=
 =?utf-8?B?VnFhdjhLWDMrTFpUWHJZdWE3THJZd0xFVWYzQ28rcTlPdkpiUGYwMUVWU01K?=
 =?utf-8?B?L3hkVk9Vd2hOTUhkeG53RWpVSVpjSG1kUndwVm9jc2tLSTN4QTRocW1Kem5i?=
 =?utf-8?B?VXJmaGV2UWpOcEErSU1ESTQ3ODhOVUFyWk0wZ1BvTWNWcGJSQ3BNcXYrNEEr?=
 =?utf-8?B?MWlMWXkvY3d0TWsxL0xld1ZBdFJ0eVRKT2JZZUY4MlY1aXkwNkUrck1kTmpu?=
 =?utf-8?B?RmZKanZSQitVUllwYXd3QXFSNHZZNXFMZnllMnJPbzhFbTJRNGI2RHZxWmpp?=
 =?utf-8?B?TElYWVNJVXhpUGxaK0I0Q3BpNFpZV0VST21zU1MvbG9EZHpjcDFBa0lkYkF1?=
 =?utf-8?B?cis2RlVZTnZDZmJHQVZpTGZvZndscTdaQjFTQjltWEdFendSSW5xdnJTVG8w?=
 =?utf-8?B?Qk1Xa2w2OUhNaUpPVG85Q2FIZXJvR1VMbnYzWVFlVFl0SjJpOWxEZnRJdHVq?=
 =?utf-8?B?aUcrYVJEeEdBcUZHMFdCWnlNamxjRnptZytkcHVxUDBTZWl3MnZud216OW1t?=
 =?utf-8?B?RTZjSXJDbll6SWdBd2t4cWNkcVlzQ0pocmtkS3dYQkdIYm5qVmExN1RCUzhr?=
 =?utf-8?B?eEpTVENScEp5Z0Q5bVVQZDZkM0hybC9RMnUrVmhIbGVObmhId1RwdElTbFBT?=
 =?utf-8?B?Rko2c0Z1UzNZK0tYNElDeU9EZUdhRHZtdFc0SmhNZWZvY2hCQi9KOGQvY1FJ?=
 =?utf-8?B?SGpxcUFGUWdERXBjSGtIcUl4QXVTYzE2ZVg5MDJNNmxtelkvMmdUcWx6MExW?=
 =?utf-8?B?bVB4TVFSbDhqYmkvamZOTzV2RDRuTmpKMk9iY2R2d1lkTzgwL1VpbjR2SHkv?=
 =?utf-8?B?YUdObklOcFRQV1M2cEVRQWdoK1NZdFFyTzVsRVFUb1cwdFdHYjVVaE5BS3RR?=
 =?utf-8?B?WnRMalYzVUZ4RXZFR0E1YWVSZEl6NmlMT0JWa3RrR3daT3d4azJoWGhGU0Iz?=
 =?utf-8?B?ZENnZXNDMVc3Nk1yWE5yb2ZXL3ZZdlMreTh1WG9ZN3BGMWtLcGVxcDBkVlN4?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4B09AF1D696CB4FABBFC081D6BA457D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2poYXdPbkM2cXBCRldQNmVYSUJwcjYrczNnN1lQSmo0bTZEZTMvdnlIcVdi?=
 =?utf-8?B?YUxwYUFnVlhNS2tEdnNieUs2eEE3TWFBMXNDNmI1MVpIdDlWRXhkTzcyTjNs?=
 =?utf-8?B?U0UrYk5oUEtnMFY1dnJqUEtWeFlBNWRRdklNdTdMTzBIb2pPN3RIUXhwQVZJ?=
 =?utf-8?B?V0hkY3RTaTdxcDZoNk5Ld1R2Tm0vSnNMWlY4L2MvWFViZU5kM1ppdGFOMi9a?=
 =?utf-8?B?UFkxSVNSeHFhNVVWaWRDNGhUQkxnVGliaGNWTk5zZG41UERocjVzZ3lQYjRq?=
 =?utf-8?B?SFlxcUdPMFFjbkczdTJyV1lJOUQxd215ZnNaRFRJcDVHNWtlb2ZPTTJFeGsr?=
 =?utf-8?B?RkExT1B0VitnQXY3QUZuVEY1UVNBdzVydExqUHU2WnQzWVVLbld0YXdZT3g4?=
 =?utf-8?B?Q3J0QXVOK1NEbUVpRkdBN3FtT0YzV2lSa09tNmJJRTNYZ3NMRExDME9mUHB4?=
 =?utf-8?B?WGsvbDVwV0x2NG1EZVJzNUROVU9zaTJWczM0TEdERnlxYTM3eThaak8wYmsx?=
 =?utf-8?B?U3B6ZnNINkkwOHoxMWFHT2MzbXNvOWJrMTZ2K2NrdHgrVTNVVkJtbjdrKy9k?=
 =?utf-8?B?YzNMeTVRYm1zREFoVzJtTFFKS2ZGbDJtbFFDSkRNblJNNEtsQ0gySFBabXRv?=
 =?utf-8?B?dUxvWVJDOTBLODVEL2dSaGk5NDlQcmhBZ25yeFcrUHcyWjBlZTllRlZrNkNz?=
 =?utf-8?B?MEtDQkF6SXFpMWVnK2o0K2RyNXkxdnVXNGZDRFk3NXhicnNmK1ZmWE82ZFFq?=
 =?utf-8?B?L1dCZUlyYUxuaDhabWpMeSszbTRJSTBsRHVUd29lcjZreVJwVWFzSkhTTXJl?=
 =?utf-8?B?cXZBZEtzdndzTXVNaXlnM3JaV1FYVm1pcGdIWjJSdTdFTW5VRUpIYmF5NThX?=
 =?utf-8?B?Yi9SSUxwWDA5Y1BLNG43TDVXNWdMZkxOYW1QaGI1Wm1tTjhIT0RiK29GMnNa?=
 =?utf-8?B?OXlYOXJhWlZnaDVQdVpnWVVGTjJJMVArRDZtTWhsWGxwa2E1dWJLYnR4c25a?=
 =?utf-8?B?ejF4MVR5T3phd3VWTW5QL3VVSU1oNWNzRCtCbWZNUFJLUFRCUHF0MUlsRUpR?=
 =?utf-8?B?L2RCYzM0RjlpaERxWXNMWVRaOVZqMlRNTWtzTzM1NHFrd1NvVWplNnFFYmFX?=
 =?utf-8?B?Mm9hMjJQdUxQV3pnVGcrdUh2eWVkVUtOZUV6c1hPbGpFbmNZTll2TU8xZlJ4?=
 =?utf-8?B?OThoeVFBSk5CQllVdnM3aHVQV3NibzY1T01ISUZXQ296M3JpL1lWMzNtOTQr?=
 =?utf-8?Q?TexFhEVoEvrcI4H?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8c1e0a-e7a1-4e11-ff71-08dac904c6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 01:32:37.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yB1PL2breS5pqZcvF5gCHpYzYCS7yI6sDtEKaTZj9wtIjvP29MAk+QHJuj4mu/8SghpXCx56bGC7KgH5pBdWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10524
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE2LzExLzIwMjIgMjA6MzcsIEZhYmlvIE0uIERlIEZyYW5jZXNjbyB3cm90ZToNCj4+
IC0gICAgIHJldHVybiAodm9pZCAqKSh1aW50cHRyX3QpbXItPm1hcFttXS0+YnVmW25dLmFkZHIg
KyBvZmZzZXQ7DQo+PiArICAgICBpZiAobXItPmlibXIudHlwZSA9PSBJQl9NUl9UWVBFX1VTRVIp
IHsNCj4+ICsgICAgICAgICAgICAgY2hhciAqcGFkZHI7DQo+PiArICAgICAgICAgICAgIHN0cnVj
dCBwYWdlICpwZyA9IG1yLT5tYXBbbV0tPmJ1ZltuXS5wYWdlOw0KPj4gKw0KPj4gKyAgICAgICAg
ICAgICBwYWRkciA9IGttYXBfbG9jYWxfcGFnZShwZyk7DQo+PiArICAgICAgICAgICAgIGlmIChw
YWRkciA9PSBOVUxMKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcHJfd2FybigiRmFpbGVk
IHRvIG1hcCBwYWdlIik7DQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+
PiArICAgICAgICAgICAgIH0NCj4gSSBrbm93IG5vdGhpbmcgYWJvdXQgdGhpcyBjb2RlIGJ1dCBJ
IGFtIGhlcmUgYXMgYSByZXN1bHQgb2YgcmVndWxhciBjaGVja3MgZm9yDQo+IGNoYW5nZXMgdG8g
SElHSE1FTSBtYXBwaW5ncyBhY3Jvc3MgdGhlIGVudGlyZSBrZXJuZWwuIFNvIHBsZWFzZSBmb3Jn
aXZlIG1lIGlmDQo+IEknbSBvYmplY3RpbmcgdG8gdGhlIGNvcnJlY3QgY2hhbmdlcy4NCj4gDQo+
IDEpIEl0IGxvb2tzIGxpa2UgdGhpcyBjb2RlIGhhZCBhIGNhbGwgdG8gcGFnZV9hZGRyZXNzKCkg
YW5kIHlvdSBjb252ZXJ0ZWQgaXQNCj4gdG8gbWFwcGluZyB3aXRoIGttYXBfbG9jYWxfcGFnZSgp
Lg0KPiANCj4gSWYgcGFnZV9hZGRyZXNzKCkgaXMgcmVsYXRlZCBhbmQgaXQgdXNlZCB0byB3b3Jr
IHByb3Blcmx5LCB0aGUgcGFnZSB5b3UgYXJlDQo+IG1hcHBpbmcgY2Fubm90IGNvbWUgZnJvbSBa
T05FX0hJR0hNRU0uIA0KDQpZZXMsIHlvdSBhcmUgdG90YWxseSByaWdodC4NCg0KDQpUaGVyZWZv
cmUsIGttYXBfbG9jYWxfcGFnZSgpIGxvb2tzIGxpa2UNCj4gYW4gb3ZlcmtpbGwuDQoNCg0KVGhl
IGNvbmZ1c2lvbiBhYm91dCB0aGUgcGFnZV9hZGRyZXNzKCkgaGVyZSBoYXMgYmVlbiByYWlzZWQg
Zm9yIGEgbG9uZyANCnRpbWVbMV1bMl0uDQoNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3Rz
L2xpbnV4LXJkbWEvbXNnMTEzMjA2Lmh0bWwNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIyMDEyMTE2MDY1NC5HQzc3MzU0N0Bpd2VpbnktREVTSzIuc2MuaW50ZWwuY29tLw0KDQoNClRo
YW5rcw0KWmhpamlhbg0KDQo+IA0KPiBJJ20gcHJvYmFibHkgbWlzc2luZyBzb21ldGhpbmcuLi4N
Cj4g
