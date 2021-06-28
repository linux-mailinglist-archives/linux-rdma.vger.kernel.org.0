Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719E63B5B44
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhF1JcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 05:32:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41928 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232536AbhF1JcO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 05:32:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S9LtRL029749;
        Mon, 28 Jun 2021 09:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=af0IkJc3lxR3eYOOygeUUzolcUHuEBHqEPd78I3SJZM=;
 b=AVT7o3DeHvfMoDbEDU/vbP+rPp3zgUSWqZKI2kHdemynJh+YhFWbBQ0D7CjKvp/GvGq+
 UAHSId69ZT2NEXvPxmfLEaR/5btlNlHTH0xOfYQU2KLMryl/l47PQB/TPgU+CC5lMlIs
 NBvj+e0pxgy1vQXHYWR4Wok2fuUMajzj5gnxyMd/p8jTXCwxTljRxMvxOUsdquaJovoM
 RvWrblddPa/++Su3P83zRKKhj8milfnh9OS2rhj6B1W4fq939bCmeQdfiDc2YUWO1LmA
 lVCERMjj3O2gA3u2pMCiUA8OgQh3a0ZqiiEeF/lq+6lWHRa03x7X/tGr+PeHQUC6xjd5 Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6pq8kxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S9LZse135012;
        Mon, 28 Jun 2021 09:29:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 39dsbv47sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 09:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX8ML19qarf0vx5n16UTX1QIU/FHqsd8XMhH/09S4ajjUMIeoWyQou7b7chx5lRY6rGHBV97raMyp5YFerswJzY5KlaNzN5jhdjTeYCYNwiPR3XrCDLO9esYmkW9BD+iYGAqR1QvkcTqDnbQsk9wTiO6GASgfVSv5qfDjKTcuKePeZo8BNswV8zFUBASgPFyZ/e9/naee7pFAJbrnKJAw+QuuUpG4ROvo4keh+PPIFuxGmUkUl4w/G2oYbW2HUzPiUyj8AEqKn2Ql3YR1da8yHpgmpxkqbwNVWru/GkLU1Zr9C0qGbb0PS2urS9TSGcyuGUwPcoftYPVyuXYM7ZGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af0IkJc3lxR3eYOOygeUUzolcUHuEBHqEPd78I3SJZM=;
 b=CQbiDsn0soOHm1FEhitebexz+z3iGO578VSR5Gd6sMNqyC8HEC3fFE3akxy+yOyLlaXb8snXBttcTTTPb6aNxWvbL4PpabcSyeJgsRiK2HWLPJtMaHATbiKF9oIBTiHy1cRtUNfb3OIOstYj2kLF9XJuOnpsJ3PIfbx6bHhtI7wPokDOost9jZ85ZhZr9abxp05Ze/CWua5tXRYyAUBBNf1VGhXIKJEYUV/zDGXwtriEufcXY1QjdfrVOChQDhv+pmAq0ANIp2wdIvEz7uPh1wJQSp7lG+3f4xaCZ966xURzPlvfrdmWgAa8WcGVzinHPildXHBT3XtU5CixGLk9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af0IkJc3lxR3eYOOygeUUzolcUHuEBHqEPd78I3SJZM=;
 b=dFtt/4q/q0l6FK/YW9u7NRLnRvBCaY+4+/Pe5ZHW1lPof/o5WSez/TkGZ/8B4e+pZNL3v0878kKWPvTkDlsmyYNLVzejq11j10klADHiw+SPjwP6JmtU5r7KZcOODJXTctNb12h9eVyjkdXiFtld3hqgNF5gB72HnidOAeGncvc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1607.namprd10.prod.outlook.com
 (2603:10b6:910:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 09:29:42 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::19cf:f38f:51e0:a5f4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:29:42 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
Subject: [PATCH v7 for-next 2/2] IB/core: Read subnet_prefix in ib_query_port via cache.
Date:   Mon, 28 Jun 2021 14:59:20 +0530
Message-Id: <20210628092920.1088-3-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628092920.1088-1-anand.a.khoje@oracle.com>
References: <20210628092920.1088-1-anand.a.khoje@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [49.36.45.114]
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AAKHOJE-T480.in.oracle.com (49.36.45.114) by TY2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:404:42::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 09:29:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68a413b-ab26-42b3-4161-08d93a17427c
X-MS-TrafficTypeDiagnostic: CY4PR10MB1607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1607CC4FE021122FFA2D3D1BC5039@CY4PR10MB1607.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvQDy8poWZw2eJ8WBrO/A8SKYGx1RHAYZ2gedo6LYAVz9/JPaonpWrRhXO4/0TCgFCFBU2c/GEto+WhbdUyzQZtz3m562BC9uu9iCZWyg5ifsWVuzPMLIcOtB5DEgavyGM58ffWA4O1zXb1e4ihJLsvKgAdIHJl89zd4Yjcb7g1RXxBnWAVv59i3Eg0dxQjcPBanbVCOKh1eftiKJdUv2SrUO+rvoYOznkOyl1/6C2UJdvlJaQ2wB1crlve47afacIN56NNzSMVFGlOqWXAPweP1+TNXYc/LIkbUoFIjQXqmoTcF8SzkFeKTw6aA0KXoqaJnDgWcLTNsN0nwlvNa5RT7ZzwSdCRP5gXhrXH9VHfD5eKupC58TFiXAzDdlRthioFQO8THXQuTCPnA9gd5+qL7lX1rw0zCfwayEp7fGodfH5zUtETUHe2MmOGWpDOHlQlEA/6Qx1M49Q5NowAyAUmsLMLN52+qYXVpRAkvLAkzoUNcCUdD3M1Ur7slerHINhM8vabVKxZje03EAQE6vLxNk8+DtwtT+5iuAoDyzDs8V4QuOlKvg/nG44ToWEJVlB07zSJVb5h9IKHUKLs9iMe2Q4qDeLJxIzZBhlBBwFeFGic5kU7vi/XN5O/ftHQSJAHX4uHocXh1CNznpbpM+WQllIp9HK8D/X3i6EyFh4sh3fUlaYoXnRoZWgj7s3K19S/BAh5a9A0wTD1L+edcSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(8676002)(956004)(36756003)(2616005)(4326008)(7696005)(103116003)(478600001)(8936002)(5660300002)(2906002)(26005)(52116002)(83380400001)(1076003)(66946007)(186003)(16526019)(66556008)(66476007)(86362001)(38350700002)(6666004)(316002)(1006002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKGzwU43e3i1zHKi1lgx8y4OD2y2X7a+x4HWUY1VJqk/fkTWEqglPsxke6ly?=
 =?us-ascii?Q?qmvqqOasZGUZ/KJHLbpM20/4p/432XiBzDo524CiSWjKeARvX7IG/nbgxU53?=
 =?us-ascii?Q?JZ6puqQNE020obTOUbh0aYrPpTQqeNnV5iiO/GhzYNqulNkKHW6NxxFA0bit?=
 =?us-ascii?Q?2Lq8EWlzKJdejwkl7GoDDzbw/GY0riFaA5OtuDkNvuMqpQzdyi2ti3zQDBWy?=
 =?us-ascii?Q?4xt22dtNknaA2A1apHQ3cFq9VhIzCxx6IzaIc8utHgm/sT4bVMF30IMfVtdq?=
 =?us-ascii?Q?czgYlt103Mhp/7tJXnXLzFW6pLr0qoHfDKQfCxNaPCK8QThThsPR763LpaKv?=
 =?us-ascii?Q?Jo7GvxCQBhCSWXgUX1Lqg/AfvqiLSy8btAaVQP44Mv+B5ISmIVKwRWEmOrtH?=
 =?us-ascii?Q?fCmnSG3dqFxebrcms3BESKRTlyYJV3Itko1g+/xeb21YK5ZEz2oZvDhIgzRM?=
 =?us-ascii?Q?HQageYUjOYbQAYFwYVyG6xkshUXs8DHk55dEonyBfxNpEhl4Q2gfSDVbVaGE?=
 =?us-ascii?Q?17ciqkGl84RYkggtKg/4Riokw12OwPf0VSEcBHcLJlBGRrBrzuu6fTTexNLL?=
 =?us-ascii?Q?jDm/FPGnINvbsxCoTuewa103AUsisEbJ/9zP7AYLWIn7LvZkqH28Zf61cd6F?=
 =?us-ascii?Q?xgkKBk262ovxDVqPZwBQtNUMyugYkCtPHi5shzYw4oK0qk4PKwKLsSgZewzI?=
 =?us-ascii?Q?efc0yBpMRA+42NZWalL9/EsxAtNS5mdEgjZHiJDlXqZ4dqJqMqrzAkX0Trek?=
 =?us-ascii?Q?4Tt10OCYH+IBkUSBoDuqLioNazHGMDrv2zdVYyPWxJxToDx007nB852PYiPy?=
 =?us-ascii?Q?IX9ZWKKk2BZZnScYPsyD5gBTANl8Ume6nHorweSolBCLCQdZd9a5lfnPIt6y?=
 =?us-ascii?Q?owbuoy8C6N6Ege+LqYg39x+uEARVSEcjENXw5rHwsE+f24vpLsWiqTTS7cMY?=
 =?us-ascii?Q?ybJ/LAKm+Kvt5aRGMY7tl80+kPF+NMZrpYQe5FMfXyi1DxLhGECs8DpvPelC?=
 =?us-ascii?Q?YJOK/3P8GG8/p3y4EdD24KOQh7ajFS8P+WbFuGomKUJa5+m5TWRV/8fKIPqq?=
 =?us-ascii?Q?8MAn6FMXNSZNEAbBuvAyDc0q7IeWF8FY0QYBem7JcYDVpyixHeY/t8s2bodW?=
 =?us-ascii?Q?pIDHAwtqNimUThGb2RBjPrUN7l7lpCBCcxohtSeGhlENPViMwPutD+idLBw/?=
 =?us-ascii?Q?hfqyDvS/BYKPQbOMAqQjqo4VlWfQfibU0ZWDJYo/pmsXcBYLx5XUnaVshh7t?=
 =?us-ascii?Q?chCGrfs8g4njLGW888al1h5/PF3fdGBXImiNGNp1cEUlSi8mIWtYHJ3yaoBs?=
 =?us-ascii?Q?ylaW1tY+fVNblC80XhnqvGzD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a413b-ab26-42b3-4161-08d93a17427c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 09:29:42.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvXzGv79u9GiY3MV9X2VTWJTjLuUhYnt9aMCB5oNRsQPAfjHfhDOr6PDL2jlLg2VCfhtzKJP6F2e9A++y1EV6voQ1wyER0l4/P8eFcHH9X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1607
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280065
X-Proofpoint-GUID: uCZ12oyEgwu_rbAWDlx-ELscXx5-wppk
X-Proofpoint-ORIG-GUID: uCZ12oyEgwu_rbAWDlx-ELscXx5-wppk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_query_port() calls device->ops.query_port() to get the port
attributes. The method of querying is device driver specific.
The same function calls device->ops.query_gid() to get the GID and
extract the subnet_prefix (gid_prefix).

The GID and subnet_prefix are stored in a cache. But they do not get
read from the cache if the device is an Infiniband device. The
following change takes advantage of the cached subnet_prefix.
Testing with RDBMS has shown a significant improvement in performance
with this change.

The variable cache_is_initialized is added because ib_query_port()
gets called early in the stage when cache is not built while reading
port immutable properties.

In that case, the default GID still gets read from HCA for IB link-
layer devices.

Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cache.c  | 1 +
 drivers/infiniband/core/device.c | 9 +++++++++
 include/rdma/ib_verbs.h          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 929399e..4150043 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1631,6 +1631,7 @@ int ib_cache_setup_one(struct ib_device *device)
 		err = ib_cache_update(device, p, true, true, true);
 		if (err)
 			return err;
+		device->port_data[p].cache_is_initialized = 1;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fa20b18..e078a48 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2063,6 +2063,15 @@ static int __ib_query_port(struct ib_device *device,
 	    IB_LINK_LAYER_INFINIBAND)
 		return 0;
 
+	if (!device->port_data[port_num].cache_is_initialized)
+		goto query_gid_from_device;
+
+	ib_get_cached_subnet_prefix(device, port_num,
+				    &port_attr->subnet_prefix);
+
+	return 0;
+
+query_gid_from_device:
 	err = device->ops.query_gid(device, port_num, 0, &gid);
 	if (err)
 		return err;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 371df1c..e692f9b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2179,6 +2179,7 @@ struct ib_port_data {
 
 	spinlock_t netdev_lock;
 
+	u8 cache_is_initialized:1;
 	struct list_head pkey_list;
 
 	struct ib_port_cache cache;
-- 
1.8.3.1

