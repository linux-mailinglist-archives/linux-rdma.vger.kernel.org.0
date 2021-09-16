Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B840DD8B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhIPPG5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:06:57 -0400
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:47456
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231702AbhIPPGy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 11:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYcUsKi60QJQTT5Db7ZpOAS6/Rq0rGkpYtwFnaD44dZy5l5P/rWPrbZuSLsGY0MOEjTdfr3T83bvb0BENw4o9EGPsTJ1Gz7wJfWETqYxSq91zgSe1lF5dONhHaORk1ugngnchHrm+ljpuUrXL9zxYtWbcsGYy6f7jpox+6hBE90bariSBZHEu9sWO7Uo5G4/0mNdVUc7LpxTUyMx8KRj9UMw326IvuIvmkAajB19Hjj6E6kiDyTGsJGmHiHLSu7I3mAnzhUGaS6VXOT4IyhWwN4mLoSmmKYEHD1+WZtXBsqEKVTt8DPiLAyVYkbNxY7YcpAAS79nWCWQlCswSx5nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cWqVQw3iupqqpKNhZGYY3m84gw9mqHM5LYw4V8Q9Q9s=;
 b=PXKl/gomV50LE5k2fjOHh6fBGMttfc6gxkFWOiIRFd8DPVN4Urfki2s/0470wMoIOpiu20rwoF9kpqbt/IqBjBVNuu8wGiaOgAjjN/87Ug1WaGsVDn/AEJyL+GJPKI6WotoBGlFJ/c8dhEasdi3A9ifbcgJ/HdWHeZR8aLMxtIPvnTpWOmba2sRzhRuIPhiu1aCYvzm8UMLEXgWI7Q2QnNHtvxp+/OxlTqkflCJgB+MKW95kJvpGsnb912Oft9HnNhPtOiFwvOvPm/Fhyz6g/UXtrvm0iXkslG38zcc1RSnY5WigEsCEsUsGsAodOvm9aDzzmKPg++6/UyUShTO20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWqVQw3iupqqpKNhZGYY3m84gw9mqHM5LYw4V8Q9Q9s=;
 b=jLgZss/o1gZhC1U/89U5hp2o6VQdnBwoZFMV5KPWPEFC97SleIWa1OOf88JEnDJkh0Sd0ZdcOPtkoQQtDwuGDYZfyeE5D16Fk0LmxuKHBhml0+S8EXzFp4a9tR+KImWFqgEpchDGsPl47P4hHHenSuSXep0fMA60nS2Y1xNmlliFIVYpUpX+XK4Tww5h1/d58M3zy4QWrgOTmtTn1EzaZ3knz7CtvA/u/GBtiRCoLwbtoWeVA4si3uG9zgJ6kLbOoqNqL4iRgZVqkFlYfnycB9nZ/0DGj64Z9lT7QkKdndLjiJw67zMkpB3ZqDMwO4TslnyEyyyzFgWP5s/6330IqQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 15:05:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:05:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>, linux-rdma@vger.kernel.org
Cc:     Lang Cheng <chenglang@huawei.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH] RDMA/hns: Work around broken constant propogation in gcc 8
Date:   Thu, 16 Sep 2021 12:05:28 -0300
Message-Id: <0-v1-c773ecb137bc+11f-hns_gcc8_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:33a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:05:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQsx6-001mTs-P2; Thu, 16 Sep 2021 12:05:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de6714cf-1c55-4e38-41f7-08d979236d55
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51265941CB86228EF45B16FAC2DC9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqbzuOsDuaI6VkXNRf6yHHheYFQcM6fCwW9aZbxs7QP3aGTqz56PF9tT/0R8NjZjyWfjm8OqS51MJjbJXpvyOiNXoDstge6ZYF30KnRbHSeYIKHTe6PQ9aMnIxodqovTsjZnLazew9wuVXvyRL7Ld6DyCN3zevZyMDfiue+VpESX9F9enYuNlk1GKff/qDyyStO9iscxAx6EwY7Y5l3mZodJ5cYi9/Yq+LXo4H/vEpYO44T2pR77Mo5M+ogu460FV5aKTI5D8yliri9dNGXbPkA24EthNcidTsmlt4jrA0xRNUpVkdjYaY8liMd+JQ7q6DA2FpABO/MEbCm0AgA+Zk8+mbyzp0xvsg6EPCPyYRFe/IQMmMkpFYhvVE7vfoHddkEHV6bCsVdpU4yvjvCpNoms5pNiQ6JQslPX/aQe7DUoKaFVHgCISrfZ5r1wfmz8L3VnBkCAPGRQqu3Br5Ga6hTcTVI7ov5SRrOJCldlkD2kDs6+GmBk34LtxE/+54Cza9JfSG6pD5dwKorVkwWmQxoQ/sBv/z4AK/0IZlwRw1pr9bN1mR06aT8vX2BnzCcgPAxoFizr/wxUP/eWpQQYwU/Tfvoq8MZTungTWFbJzw7vcyVbvOXPg+/sXdhkgfg9LAa1FH4/jIM+CRW2rXM7EinwYuhbPGD56WyecCUAhv1B6uEMCMEH4RuUFZdawyha
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(316002)(478600001)(54906003)(38100700002)(36756003)(86362001)(4326008)(83380400001)(40140700001)(8676002)(66556008)(66946007)(9746002)(2906002)(9786002)(186003)(66476007)(8936002)(26005)(2616005)(5660300002)(426003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zAc+pc3W0h4k/U77Rkq20XD5IGPfeXElckj+8gx0akJvJI5HvGGQ+iDcR0hp?=
 =?us-ascii?Q?6AgcTaUtGpttIME364u0Ihcx2oBVyfYS/gWXrJQMEpdv3lgeMP+6+HV3AQu9?=
 =?us-ascii?Q?IzHi7oq2qO99DM9y1oljOR03ntblZIYefsiWRpvOdKe/z63ws6xayCHNMz/Q?=
 =?us-ascii?Q?sx/P+huVtprkwlF/4YBYd6fet5QPGvHsSOPOxSOEwyrnExyATKRfh2MSz2sO?=
 =?us-ascii?Q?oVn8rnhVgRCt8fEZHxpTiWrdLAucgfVLNYMODwsZp3v1u6oV5XejbikenkOk?=
 =?us-ascii?Q?6xu2N5QFksduYGD3gLDhqs/JkwazWF5rQxJii9hp8CGVqSKrkvWen66lLByW?=
 =?us-ascii?Q?3iAGhmNYYxio1CQjG9ZZw3j5bpmtAhbXF4MBc34hkqxaHkd3Ss7ZQ6lC0ADa?=
 =?us-ascii?Q?C6tvylRPcpC+pGlthAaWRIZ9ZLyYgVk2Zip4LNJmBjY4TLOzOCeu9mN+h/sW?=
 =?us-ascii?Q?rq+4qBIRWLUJlaBkNj4FTs2j4EqHKnRe9CDZb3ZShKX6P8saNep9Zor5l2Dg?=
 =?us-ascii?Q?Zz+upC6p5BJ63FaCnVqSjqWnPkxVmKowBcOu+AmzSxafhj8hFQPOdwWop0CZ?=
 =?us-ascii?Q?fCZjfwehJ5e3e4qc2HTf2FOlgEdQsIPtUOlyN7iln8OoCtbh/kOQmV4FpaKL?=
 =?us-ascii?Q?KFerL5ZgYhDmWECJ6n1YGScXXtoo3YicVe+kZPiEwOjHsUQoXbxPSnu9sL5g?=
 =?us-ascii?Q?qXKgQXZULU876jaeT9RAEYqseRmFEsP/8cOAUOoe8FeRoPfz9diA4oJpcI2E?=
 =?us-ascii?Q?rR9UZBMoqNym34ladKbOdweHBx/8uJu91doRABEFWgokfBku5jzrR2PVV1MM?=
 =?us-ascii?Q?/R+64+DIDAqaIi2Oz7axBh9rmt0amnFV2Ggk4hsL1VssOjdfqxw4J+j8Zxob?=
 =?us-ascii?Q?d0zG4k7r3vjxZNsoIhXTrheum7V4OoMUvYdVCdxbYJM92zW6JmqZfRIc1ra/?=
 =?us-ascii?Q?ExO2Qi+vFp/Vu5h+yfcmGq9HhCc7n+1vpMwCFYDCMjr36xQKQxNVi5rF/y5H?=
 =?us-ascii?Q?a45EuDQp6rcJUYq/kAzRKBwiFJGQg/DEbxFNwUMDlLOhloQ6QD8UopZcf5vu?=
 =?us-ascii?Q?53ue3XZoQKv65iFOnp2NVOo0E8M89sYnXhy76ldELw34OMVNt2X/OFXsqsZm?=
 =?us-ascii?Q?/aY0dATnt+8oghBvjNhBIuQgR1EVWBDfbFAo6eTmp8Q9CnSYdnYQ1LLXAVhO?=
 =?us-ascii?Q?/BmO6hkSreMfIVRcQh3ClxFZbgOGV1Bj7LARRgyk5SreOAGWn8GECzz4lFqO?=
 =?us-ascii?Q?G45AnjnT+mdHIP4GPo76RSDjvYAb30q18d4e8nB9hQ67cKbmd1OzcXLhkkO7?=
 =?us-ascii?Q?lWiWIVrQ9OtHUizljWQWODfP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6714cf-1c55-4e38-41f7-08d979236d55
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:05:31.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vRO8jkYtpJiMMhVVdYc9w2R3chVFwW0NA9KNOVy80ILbYtcypBJYzt6Li8WPGMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

gcc 8.3 and 5.4 throw this:

In function 'modify_qp_init_to_rtr',
././include/linux/compiler_types.h:322:38: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
[..]
drivers/infiniband/hw/hns/hns_roce_common.h:91:52: note: in expansion of macro 'FIELD_PREP'
   *((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
                                                    ^~~~~~~~~~
drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
 #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
                                       ^~~~~~~~~~~~~
drivers/infiniband/hw/hns/hns_roce_hw_v2.c:4412:2: note: in expansion of macro 'hr_reg_write'
  hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);

Because gcc has miscalculated the constantness of lp_pktn_ini:

	mtu = ib_mtu_enum_to_int(ib_mtu);
	if (WARN_ON(mtu < 0)) [..]
	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);

Since mtu is limited to {256,512,1024,2048,4096} lp_pktn_ini is between 4
and 8 which is compatible with the 4 bit field in the FIELD_PREP.

Work around this broken compiler by adding a 'can never be true'
constraint on lp_pktn_ini's value which clears out the problem.

Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5b9953105752c3..a9c00a2e8ebdbb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4397,7 +4397,12 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_qp->path_mtu = ib_mtu;
 
 	mtu = ib_mtu_enum_to_int(ib_mtu);
-	if (WARN_ON(mtu < 0))
+	if (WARN_ON(mtu <= 0))
+		return -EINVAL;
+#define MAX_LP_MSG_LEN 65536
+	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
+	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
+	if (WARN_ON(lp_pktn_ini >= 0xF))
 		return -EINVAL;
 
 	if (attr_mask & IB_QP_PATH_MTU) {
@@ -4405,10 +4410,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		hr_reg_clear(qpc_mask, QPC_MTU);
 	}
 
-#define MAX_LP_MSG_LEN 65536
-	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
-	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / mtu);
-
 	hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
 	hr_reg_clear(qpc_mask, QPC_LP_PKTN_INI);
 

base-commit: ad17bbef3dd573da937816edc0ab84fed6a17fa6
-- 
2.33.0

