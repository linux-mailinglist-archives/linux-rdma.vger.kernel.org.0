Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A7568010
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiGFHii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGFHih (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 03:38:37 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C71A38F
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 00:38:36 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26631taK028091;
        Wed, 6 Jul 2022 07:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TWcK5CHJ2560jcSNsFzPsETqSK85QvU6DtyIbIVESuk=;
 b=HBfQR46zP7gMes5tYxX3bpAe26fdIvqCSqi7cuYjOJCPlTzNtNXwriUSUyR4IhXRnkCJ
 vmLMtZbLeh6iXdGzG1IektwgNNqjjIDa8RaB1t7Q+sbN2kOZDKdkZBEewxSmxhF6MyBO
 ZkS4Z0i/9Arc240NrufB9TieP9Td3ahpgfxUF44OMG3y1M+lxaSHwu1Bbe1m7b3sGRKd
 vRMenAXbkwNOqyJbwVopsISW9yr4mWJ8UfXhVTnUgSKlXG0mTsfxvrtbOoNvipZUEvzq
 SEOuv1AGe73z7noIKM7Uy1jxJIgcW0ck4se4/ZMlcExp3TJRKz3cwyCPUdCReOh0xGBX mw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h4ubwwqkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 07:38:26 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 94A4A14799;
        Wed,  6 Jul 2022 07:38:25 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Jul 2022 19:38:25 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 5 Jul 2022 19:38:25 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Jul 2022 19:38:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeW7THKx1nqLq221JkxaCmxjq5TemrFT0M9PT/JwktzULZTTKpWxVal+2dlkECnVaox526eATujtK6HfL91LCvUb2B1ijAYcN0QcT4UN8ZKLV1P2LOnnCOSjqKyXHIGqu4xeZN7wPQlnHzi/dW7sypGurZ17hbCIL1vXkua/wUwP4AVIy9CqoALRWtjgVYhHDARzXa+EgKrsm25pRTudVXqfzrmXCTo6QIIIx9iIMguZuvrf9h4SfH7bsMbRVQ8XH7U8jNujR60SEcAt33Me0pUjQOV6YXA3qLv0s/fVzELh/f5JZ/zHkZfXf6w9cPj7kO4zN3LNXxDRTY4Gl5whnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWcK5CHJ2560jcSNsFzPsETqSK85QvU6DtyIbIVESuk=;
 b=AQDdz/kdxMy8TBIW9+IGYB1Q9lV+C1vymQWFutUJJf7XB+qRcyRlmhEobOZ55lUaIC3gtEv3Gj8LKCaoggmPDJLxE1W22veYZFQYxHQ53RXOZ8jQ+ytdspvcQcNrA7r7limwVrYyh0zmOoVJdjcrN43MevhgpvGwvTQmax3qhyNpIxmPsg0nmRC2CSubQ3VxFzM+RHKYdwuENrzXUF4lzD94ANSaWu1aLdO03hSj1PK7Xs1AGNxREZcQ8/GrOV1lAuw0mXbpl3/QB+mFlAaslLOydyZs89c//wzcLxkxzZpOkHtxa6GW+zgLAWhMVDa7bhpy5NLf8sLvCJNQuqJrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MN0PR84MB3071.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Wed, 6 Jul
 2022 07:38:23 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5417.016; Wed, 6 Jul 2022
 07:38:23 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Thread-Topic: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Thread-Index: AQHYkGTsdM5eQgjGKEuFc6E6UM42Qq1w9P+g
Date:   Wed, 6 Jul 2022 07:38:23 +0000
Message-ID: <MW4PR84MB23075C8A422D7C87C5F0C4B7BC809@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220705114603.6768-1-yangx.jy@fujitsu.com>
 <20220705114603.6768-2-yangx.jy@fujitsu.com>
In-Reply-To: <20220705114603.6768-2-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a18d6b5b-b368-44b9-10aa-08da5f22818c
x-ms-traffictypediagnostic: MN0PR84MB3071:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cw929klS5RLM73Vywwl5EXfTgm9H458jQjMtQEPMweQaYE7RtgGRjf7ncgVl4/1YDW1fCNazcsTzugat/BAA3tfuuOs8qEbWW28dFZLR0gEFI2WJVCN3GrEU8dppMBp5iZRPgTZiCUpxpTFyKAsxhrMkUUZ0rfFzLdbYefNyjRsZ+8aWN014phbz52HFUCjV27yWHq1dav4EBqvjXswHnJHCO98CTrrdx8+DmFRfEuy5YMcmX85Ark0nBZE6zUWztIHQb1HhiEOVsHHXnYOGf73tV65yQB8IRiGKpCALlNn+DT2KyBoTeFhmecZKiKZg+WCT/LIukqYGdcaHk0sgtIW0NJYfeFW7Fs7/ZZCuCTW89k5myQjFI/buctTW+EMaHcc6UznIPQQCyfPhUdhQpjl5waqA8o9zg+gfhqdLnTyKxkX5En81WRAyt21jJO8+x2dc1e/COaDBJKJUM7VeJ9EAidRD7dw4jHO4SbPL2+mD7HyvHKE1p50JP4PpZIFpvE0+fHkOVwiHABccMqFdbs0wJguJg4RV8r7jQkx2hVWpWA2bezFSsrxsssvHvP087lzSQg/brXMo0YHtGntJTiWUp5V7rxPFzbGVE2K7haCmafh1rKaaeKllRBnONmEkxOQuJMT4XOBmj24ZV9HY5Nn/G1Ps3+/FZyLjlKD9vrk9lyY9wim562HdsEbmtYaKS7+rFkj+Qri5uJJ2u+NJWsrCYU0acSIYersBg7cJ00IOJWm70CdaDDDxEE3jtNR96wAqnJqEi+DszsCcUZ0TMMvX22xj9itjjOFaxgb+7IvH3Iqs1kMksVO+liMHuITn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(478600001)(38100700002)(71200400001)(186003)(7696005)(6506007)(41300700001)(53546011)(110136005)(2906002)(33656002)(66556008)(316002)(122000001)(54906003)(8936002)(5660300002)(82960400001)(86362001)(38070700005)(52536014)(26005)(9686003)(83380400001)(55016003)(66946007)(66476007)(66446008)(64756008)(4326008)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZMvEM/BV72Ub+cR0Yjpkv+9w8NXZLvpxOcLRUcJn+aSZPMUsdBYyLONxN7L3?=
 =?us-ascii?Q?JlsGSbp9ppHS2kCXqa+KsMP7ujqIRUudi6Btr8RRhk96pfJtkKKAhV8YU8yC?=
 =?us-ascii?Q?kNyzOK4Jap45/ojErf4A7C+ESEj7+xqPln3mfDXda4y9SXBSbWpWkM/VEcxw?=
 =?us-ascii?Q?VbSIRH60HpMMMUoI9dqx47X6Zb1e1kU9A22uqbmRQGnQaF5JZbDMjEyriT8k?=
 =?us-ascii?Q?XAi3IWjBTwaR8hpKkE/FDNEKC0jRZJ+dC9OzSvMqP8uUIH+L63Jr1PjJgaMh?=
 =?us-ascii?Q?LZJHy2Zk1Idy0kjMUTvWCW8dfKZ1X7pv2zRb5WHNiShkfFrG3kl7vfi94XYd?=
 =?us-ascii?Q?mQ+IekGp9JNsj3pkWuOpy7Qp/gQ2p8XW6Mmkr9snerCqmFSmQ2y4NauTdIHv?=
 =?us-ascii?Q?2LESKSoFWs4IKs4OnBxFHWOiGhCCEy7ENKBvuouDOhoocUPPFJ+3gbSuRwgW?=
 =?us-ascii?Q?oL8vVXB1l7m4vIOpvSVyg2qRuic/gpr0TGHpiDZfodCXPQyshMKO9otwrj+U?=
 =?us-ascii?Q?O/A0H5Iiw5xQq5WLfBLFSynXDXesxuOt3vdT3abPB++p/DqPJFfQXRUw05Ac?=
 =?us-ascii?Q?N6uE/bqyiKFVZ4O1jHXqxzRIn0iZKeV03Pq9bNUsf2BodkzjDG6ehydyUVi0?=
 =?us-ascii?Q?dJ962mSys+i1r6Ul/B1g1E5cJS4bMN1wyVa5kFCd917PjYEGDHBXMJKpZKYv?=
 =?us-ascii?Q?axfLi8nOJyI8pWW5pmO5/1k6QQUxxGasj3CesdDiAAMNuHJnxSlqvrOt6kCE?=
 =?us-ascii?Q?fBlH0gJAPm7TCnzBajieeoJMoOL+qjG9HG7Jr/QkykT6YGedn8mxYqUyNenW?=
 =?us-ascii?Q?XOhbJW4X0NDNrwiftQ2ePrZ2WbP0/YsGzlAWxjW+/j9nxN2k/FJkaFMk2x4+?=
 =?us-ascii?Q?q67+6XGCe79hhSjhZj0BLLJYueHmgbb99bEJOy4eiZchAHKV5UOHqsZzYlkP?=
 =?us-ascii?Q?DXHq/4S6P9JUeCRc5hh77bdGtoKXGmedM3Scto36HWbQRr/Fsi8/v6gL8xcE?=
 =?us-ascii?Q?fvqT5G21BBFMlpZxkWGLqxVkxF2a7/72fugfFNDoyq1EEE4W2tqqlCcOLajO?=
 =?us-ascii?Q?GZVcqG9ZS2WxLZe8W7437XLMO2PKR2PsrfeWGGPC7s43AY9m/J73XwoLlstc?=
 =?us-ascii?Q?e5FMDi8eSFFpT+JCYFAWCHZaXUqked6JK162c1M37eTgF3f9ehGlvribWI9V?=
 =?us-ascii?Q?MRpcBnN+ijFlzoZqywgF4GkiO+PpsRxzVqn+VtdgaveI1Dmv84XMFmF9dLYl?=
 =?us-ascii?Q?cre/NZ+6HRIGHYLb+1dtN6pBVoGk0krhGkI7Lk+vgp+uMj7kFFJg5IPvGPbx?=
 =?us-ascii?Q?crE5R7/wmUjCE20d8f42JXgvAjtuYsMNooUDyKBYHiYc3iYwy5QIzguPupj5?=
 =?us-ascii?Q?wpi/iHAeGRvzPQLdZPIlxdm0Ywo5/Ejd1BFlmMgJFjo7TX1eD5A+iocJEwZh?=
 =?us-ascii?Q?PYJUL9ZjHtN/1GujzDDPbrVs9rgsYUqqeshVPCpdIBzqXMK6E4dGyHWkHFbG?=
 =?us-ascii?Q?2leEEWcFbjQ/D2mk35obV2mpLGrRZzxtDQhmDlAD0rtqeXHVTwmTI80Q6M9r?=
 =?us-ascii?Q?Acrn7m7mL7joB0SvPNZ2n0hrtj8qLAVUWfZ7obqQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a18d6b5b-b368-44b9-10aa-08da5f22818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 07:38:23.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OB5a9M0Exzx7zVmI/WQDsfl42znJD0oDk0F5TR3X0TnQmNBp9gzj7/JHiqUd7rJWPrzvC4hfOtrvFQSDCROlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3071
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: SQW1fUg8F0YMcvP86wYdGFVk_1ywiaTu
X-Proofpoint-ORIG-GUID: SQW1fUg8F0YMcvP86wYdGFVk_1ywiaTu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060027
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Generally over time I have been adding a rxe_ prefix to all searchable name=
s static or non static.
This avoids collisions with similar names in other drivers with e.g. ctags.=
 I agree a unified naming
Scheme is good but would like to see one with a common prefix for subroutin=
e names.

Bob

-----Original Message-----
From: Xiao Yang <yangx.jy@fujitsu.com>=20
Sent: Tuesday, July 5, 2022 6:46 AM
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org; jgg@ziepe.ca; rpearsonhpe@gmail.com; zyjzyj2000@gmail.=
com; Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply

It's better to use the unified naming format.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/r=
xe/rxe_resp.c
index 5536582b8fe4..265e46fe050f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -595,7 +595,7 @@ static struct resp_res *rxe_prepare_res(struct rxe_qp *=
qp,
 /* Guarantee atomicity of atomic operations at the machine level. */  stat=
ic DEFINE_SPINLOCK(atomic_ops_lock);
=20
-static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
+static enum resp_states atomic_reply(struct rxe_qp *qp,
 					 struct rxe_pkt_info *pkt)
 {
 	u64 *vaddr;
@@ -1333,7 +1333,7 @@ int rxe_responder(void *arg)
 			state =3D read_reply(qp, pkt);
 			break;
 		case RESPST_ATOMIC_REPLY:
-			state =3D rxe_atomic_reply(qp, pkt);
+			state =3D atomic_reply(qp, pkt);
 			break;
 		case RESPST_ACKNOWLEDGE:
 			state =3D acknowledge(qp, pkt);
--
2.34.1



