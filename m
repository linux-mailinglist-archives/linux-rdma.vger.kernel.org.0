Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48430747E9B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGEHwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGEHwv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 03:52:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851061709;
        Wed,  5 Jul 2023 00:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOhUjjNJE61ZYtMjoQRNYi3pd/0uMgq7UR5+RJa/42vxUPvdKEYFKs8jAIKUn9W28UVLH9AriaQAxiE3RycMalMNiBBkXPk2dbBFKZd9WpnXfKaGomJtEqTWB0DWciT4MkWuRo89dhMDLOFhoYMDmSVh0odp3G9rHVwdpjIfhWRW6Tp1/SI4LVDBBy63+icvO94gFCnJGp3DGWxTtpbadB9ck5ZBWGE7p5BENsw/XusTM/N9A6uz6rHbQCC8xB98+WlRnlCkJ0WLhB9rUfOpybs/ey3Xcd4P/rUqZe4bYnNKpsXkiLNhj1+EOyDg7F+MynLQmzR6r8VZzwZCF1cxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZaPnNbtIs/MqISynpybKdYjCtNvKgpj5QqeR8Po0TI=;
 b=ZG8qWdUtqLEV6CL/i14bUykIliXJbyomCKpGjCU5i/Wi4Itd3PS+FOhKYQCxkflndrldoyoiksCKI1f56kMzoMYkwurPC3wIUBp7PMuKVl/M7yb0KS6ZLl46Yf8CKBnukST7lxoOudVeYDqe5CHuK31GzDltuq/U/iXAEi0lqIvhUAFNqo33YPitJuF3DM0lyg6aKKJo7cS79CFXRTMkN3DYgtxtH6Vp89+RRY/lPgT0L+q4s+oGC9+MiBXKh2tLeTOf1vdiGV7gGPTTbkjNKcGjPr5H6DvavxMCwS8uK4e9uaYOKbVqPI8zRqrRnKB547J5Gsc39QZerql50v6XDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZaPnNbtIs/MqISynpybKdYjCtNvKgpj5QqeR8Po0TI=;
 b=NhTOwRGt1TpMWLv2fjnBHj0E0HB9Y7cic/nuO4CcuYs5t/Kz1hgc3F3fFcbtakhCTNXBMc2J1SOpTTOY4efaZVcTQ1mT4QGBX9NWZfrL8rzssHGo0ymeUa6Rf8tVfqwhOAtc/KkNZX2edcTdDXTg0xr15y5RU5WLjHXRzi3Z3+S6ZTU/Tkt5d/6HvJTre/CkEpoQwrb2ZVb5XJIlsw7+rcCVQ2DnAnv0JjorSD+enN8K3f1YSa+TFJNOyxiIgrx1qKblBGjOiycZ+bQnVOdaxfLGoWV/pN0MhI+WnJQezZYoWoyM25sky10M6kKh2ItNsNpr2AJX6no0eS6K8vXQIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5478.apcprd06.prod.outlook.com (2603:1096:101:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 07:52:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:52:35 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org (open list:QLOGIC QL4xxx RDMA DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: qedr: remove duplicate assignments
Date:   Wed,  5 Jul 2023 15:52:25 +0800
Message-Id: <20230705075225.11954-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d966214-0aa4-4337-9f4b-08db7d2ccbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /V1wmPaqyaU8VA6F16gUe5zP0OwlIoZZAbal3zk4ALZgbYU+Kj9/R3VB0d9p+zgk5c3JPkmnfh/jXB2Ko7iGv70eaFJvRyRtJB8xzyCK25LhDy6DxrAWpHszcO7EXUDyrUfb5aNAD4GbdNY95q08+pBrefUOKptOGN/KyHVWZUL9Qc2JuMNIiba0unW9Nh57fukZ6uqW6G22wHovtUvBFMWKwweEqQAiG4e3XOqMUsWXHsCV1nVKrMo5AMsPh659qY4SA9nz7kaE7JT6iS270PU+BzvOw13DrYCkv3ZTFGXUYv0oXc+FbhnNngVnvWbMe6BphHEEycpcwaUD04jc3vKoXU/AI+nx/qlHmLPZhgkpN4Jw0S3F842W6+W7oGMxEf7qdKsPFSaoSyiim4p+NcE0hp6gedA6sdyTkAiJjUK1DaMdWrxffwNrCSegftxIEjMCt0sCrUywtGgiF67VTol9EmOyuC7j82X312IdxibEX823KxYxt/pPKNRznCIoXHz66tSFrQF/JJPKE1Hn0+EKLPXopOSVEv5DgUmt+sRUZ9Pa39EAPDZaTl7v2zwbdchAH37pUnnCAnFIIR4mgg6XY79AIfJTor3UyUQtpfbb/OHfG2CKJ8Pjbo7SdrqG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(38100700002)(38350700002)(41300700001)(8676002)(8936002)(83380400001)(2616005)(316002)(4326008)(66556008)(66476007)(66946007)(4744005)(2906002)(5660300002)(86362001)(52116002)(1076003)(6506007)(107886003)(6486002)(186003)(36756003)(110136005)(6666004)(26005)(478600001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4TZS+dmw7bGC86gNKNdSaFAo599KeMtb360dC1oQLb+2/dxNiSOLMtVq5mY?=
 =?us-ascii?Q?M0qqLlz1A5OhJ6++B6fhMOex1Vn2V/KGWj/qa0h1HKV7ebBCXjSuCVURJhED?=
 =?us-ascii?Q?3jJ1xyuhxH3QlIBGmUGLEz7tjgzryHy2AZ0F6MP7SmnRs+gz/0jSGI9r89ZK?=
 =?us-ascii?Q?lY47UPVbKpYzTbqu4P8ISAUEUc7OfS4igcMdbfklOdWnTqOgJDpip1XOzz4Z?=
 =?us-ascii?Q?+vNrce1F1pR18WtszcAOrbujcAwbnIJkUdh1n5J/A0FuFfs8CIXPDPPgAW+a?=
 =?us-ascii?Q?GbssQV4mwe+FU7vWOWaa17LcSZIQ26xqnMM3gggwM60CF/FTeRNgXJDnslX5?=
 =?us-ascii?Q?yDIB/vJG7+R1mVjYtyhVGA3pGBwbKJjq9P+x5bDh6UcjUYhawU43SL7fkjbw?=
 =?us-ascii?Q?IVoHoXeo3/mA5OyGWR6/v1LbzACueE0kuVFksV0CgGDQMMlZJXW9zciKrcHx?=
 =?us-ascii?Q?ovUPyE7AFGsdMtydnKwkmjRzpUkuiiWxUrYoL1yAMI4Q02yrbAtFiEcPT8SQ?=
 =?us-ascii?Q?/rHAmq3lOWVAkZSHNzMnQWSMdJuqqhbxHCoVclr0YYiPlFEzl9CD85Xc9R+U?=
 =?us-ascii?Q?if2vSC4caCDShDLVHvnGdIZoRgjctGdP9MWBVpQ0MXJkRoDYozUEkfjybJuj?=
 =?us-ascii?Q?F38RWDso+HZxzCLnXSHmlsmCOg9ws7BMMqgA54JdBHxH44ocvkzOoUjge6JY?=
 =?us-ascii?Q?mLbjBlYdVSka3xf8U1uqdDDfNMvlfRoaUk0R+73SGqwj4DXtLyVUqaXNCKgI?=
 =?us-ascii?Q?CS5lol21QPjCTn/oN8Cf25nsHT/8Bg+yS6UUXoK6+57AE7GcoSq4poH4ulsx?=
 =?us-ascii?Q?BQRlxrsuYHMu8R8gp3YGd7fYE5xcgjl5ts5WlKeR4jm6dOZJc4Jf/y7va6/9?=
 =?us-ascii?Q?EI0J/c3vttwU65D5XwlzgRJnHMpHGH2HG2YrIztPbDwOyoqP4DAkruxp3BjP?=
 =?us-ascii?Q?wtrmDos8WRs5+hs0komPgDEvSrXBFiptDlnMnbhzDGRtEPO6mGUyMz6GZVip?=
 =?us-ascii?Q?J1//CurVN9zxRiRywK404I5I6WXl2wYdhfTSqX1pSAflD03djeqftEHmr/YT?=
 =?us-ascii?Q?Km/e61nn2IcCaTGxriWkkJbbVMZi98/WZ+xZyWocPbQGxP1ZYYLA+vhxaQPr?=
 =?us-ascii?Q?clTSX+1h1HKWFN4mLREIU7tiAKAEW7zKHJC+GAgcRE2XnGNqCmGZJxsym8Tj?=
 =?us-ascii?Q?Uepv18jxn1Jzg8wqwGHuubvdAqTc1L7RzkPVSeDQdSaNd+R8HJ96IP4fDRFz?=
 =?us-ascii?Q?ZG/yhR7sHm3x/iLqG+RE0xIFZIdLV1UDWC09ffNBS5fIW1kZikdosFHQIZpg?=
 =?us-ascii?Q?gnaaVZcnwxrIJYO/jR2yQ9MZbX1eHZfoYYNmrTFCtdGtiQGJAkfuG8GK3CcZ?=
 =?us-ascii?Q?4xupddAMHntQdEevv2Xaxn7y/jbVL8joVspPQnSWo5QojHjfTF5GKtJUGobW?=
 =?us-ascii?Q?pFo4qr/FU5AbBOLSaMLrTQv2Dfz9slSQHvIAXJaE7sz2ottKTRY2VjdF0pbO?=
 =?us-ascii?Q?yJKw152KiaSWq/8tjorjN0Ffp0jWH7xFPoQLKdEqZdiZVm6/tKznKqKH37nz?=
 =?us-ascii?Q?iocpRPywTfolDRncHwYoCRT/mrRfrwKFrDOs62ph?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d966214-0aa4-4337-9f4b-08db7d2ccbc8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:52:35.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqvRZlRBqk0ivG2r6HHmYFzP9x9+LE1kpShiA9CksAvQXC6+Es7ZyObrChtz5MwbQmIEt3d5D6GiXELKhJOyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5478
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

make dev->gsi_rqcq->cq_type avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index 05307c148..859f66a51 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -354,7 +354,6 @@ int qedr_create_gsi_qp(struct qedr_dev *dev, struct ib_qp_init_attr *attrs,
 	/* the GSI CQ is handled by the driver so remove it from the FW */
 	qedr_destroy_gsi_cq(dev, attrs);
 	dev->gsi_rqcq->cq_type = QEDR_CQ_TYPE_GSI;
-	dev->gsi_rqcq->cq_type = QEDR_CQ_TYPE_GSI;
 
 	DP_DEBUG(dev, QEDR_MSG_GSI, "created GSI QP %p\n", qp);
 
-- 
2.39.0

