Return-Path: <linux-rdma+bounces-4472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52B95A483
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C0B21F86
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A71B5313;
	Wed, 21 Aug 2024 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXRsIkdO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6701B3B0C;
	Wed, 21 Aug 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263882; cv=fail; b=CmWSHmyoixodxq/BwEh2Ev1IpORpVa/665Cr+RLMMeTGyqihglH+TGaGNxnd/jG4dVi3Rfi1tmP1bKagPnAl9/AQCWQzb9+LILJFFOlAsldpHXkk8VQCRpL4+Oi9CnRV0uycH1CZrsWsP8HkqPs8yfznnon3+4VM5/I6p1fBTlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263882; c=relaxed/simple;
	bh=H8CRQHybIweGG8+VFkqysgEPGA81TafLEKlFY7L/gIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1VV7/W94XTsqfQ9mkcH8fAJtjSB9plmlOPxq1rYZE26gX5QcAr0ziGLmfXLHAmS5Er9rkXf0vJ4sykcKcuiFadLcVsTxCrBNUGVExam2KyVlCCqZ7i4GyIKqeS1TVNyFQ7PFUNYHF+CWO75cBUlUWMo8Uq69UX44c3p+9R5p7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CXRsIkdO; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrjdZsRhmTA6T229AS9GSulKZS2wnyFcZbcSjBG1dz773Z93ae5RIzzNdjXCHsZbcvYV0VcF8T0AY3TC0adBge5db0LW3T8UFiAXgf7T6TN+h2KxpwcjjyUhkA8fGLYpzo+2Jc+sp8IkNyrs80jEede4KYcLKfBK1x7PjofgCvpKVdgQwVwwNA+o5rNU08uJ851IkKmKLAqdnzy5/YGUvo2S+Y9xSfEa/tAIgtPX3ZI3JYRAThYsvQ4LC/8SxDzmJDpwy8XgBDTlSqid5+J4mhAx5EXoEtck+V+z7AwMO0I52LjG99ZED8t0vqSeOvJfGm2dhMu342UWIeM1gkhL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8T3SfDAXcb5R8P/USBSV95lHUF35XIFqpVPS1ouj/I=;
 b=awpXsNJNeS9oEm0QxhaKoygMXX5ipmQjOPfd9dRhISpKiCNX4dSVmI3MshmCoxBjHQLBM629jA9LAwVpd4TLC9RIQhCUVdhMu1dNpL351FuNnywSap5KsuxQgM4g8OQ9PtTajy3XOjvt0AlR95P+3SaLSmtvCGNFUK5umFJLW+u4T6Ou5sit31q+TXntRJluGa2njHaBl/UbhanFEmWd8xjC3XSpz7fmqQrUYE0r1s95s/7CFQQUnzdLgRRs/dSw3o16Cr7Wd2n2wQthf0XpVOtXGw8eleqYZpNGj9JflPvUGnhd73T8x8bysZTbR+hv0IEBovpHqjZYQ1H9P/68PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8T3SfDAXcb5R8P/USBSV95lHUF35XIFqpVPS1ouj/I=;
 b=CXRsIkdOX6LdFylKEoFfWd5OHRW1AfpnfD1/tY4EFLiRLTXeI5M6neL13fMYZ3X8+YPFHo1x99NB5foFfgFF9jis/Y7TAG9kvhHhM9SKanZs9urLy96lPVl3iwrIWvCmC5ff6tIlQsEno45WLPdFqrUMHVWI5opu1wludNRyNgC3eSDT4tpZQuM+1oLXQDz8mTb7VP4V5Jt1rpG04Ocuxkcjg1GTZCGwWmIFIj8LryQ6kyiKIMTtvRuROMiGiaNlvnESPQYUsCQ26KdCDyYBsggT+PVB4Cd6U3z3/M9lJTS0/6+KpUri8AMvJ3H+D470ysp0gsByRmcImFfVpr2veg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 03/10] fwctl: FWCTL_INFO to return basic information about the device
Date: Wed, 21 Aug 2024 15:10:55 -0300
Message-ID: <3-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:408:d4::11) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: fea86944-e00e-4609-2a57-08dcc20c9f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6o3KjWZ+mqwOdEgQMiU+jjke4jHUEkYgwRsfy5O1jH3mp54GoKUMOA4/gAub?=
 =?us-ascii?Q?GEVsC9wJdqeBfLW78sS0fTfRt3ivVQ13Z1ezch6jeu22oOY7VNF/KHMj10QX?=
 =?us-ascii?Q?EUPKuxVlBVAw86yC6HJ+HWlW89ZvcrhCixNqPtvARnoK/x4p3Q+SN82gd+HS?=
 =?us-ascii?Q?dajjnd1QMGxhgDjY+a27A0m7PdoZv8Vyaw3OIGcfW5cqt8YtdumfF95Gvhy+?=
 =?us-ascii?Q?K22cx7/y2MHSsnQKVRM34zJuiJuAZyya0HAwFjfoi/QekmN0YlI7Kec2q1D6?=
 =?us-ascii?Q?s493OaWGG1wOlEkvJfCdfnuSlIOF+V5S9kP9urjCXte/UGqTuI5sDPdGoxNH?=
 =?us-ascii?Q?+X0F1TIKn5uyzyLsMLxQ2oFWnobynOze/8LtIh+s8oozngeApsWaTfm1sIUV?=
 =?us-ascii?Q?Fv7jueWqHNhP0vSwg9GlauexQgQf2CSktZis81YEcbA5PQHI85qRgmzXTJE/?=
 =?us-ascii?Q?Jb16+huoJWyt8ahN5j+qJ/xpE3Mzk/JG5qWmEIJSRc0Y3OXFcDcuO3kF6nkV?=
 =?us-ascii?Q?VJ5fMvFeGBUuGixefimhhk5kDS8xeELOooyWQZ1x6wc2XujZorf19/vrmEML?=
 =?us-ascii?Q?e+8ABh97N/iMWWNs34bKWyqC6IXDM5cy8nnMEXHIaU7RYsf45av7EMVaNNjQ?=
 =?us-ascii?Q?xH6bsm9K0cTTpx1ZJP7QkYdSgBB5lSOjZqnJkwHVRTlAmctEVJKaS7JeXhnS?=
 =?us-ascii?Q?Evlc6/w/z3b8hHprXYLy4cPNpOpnjEyAFQHFjRYaB1ZiGhSYaIQe7sbkM7R9?=
 =?us-ascii?Q?S3oJ53H3cffpyc/1P9tLZWaaZTKz//K69Kyk7QAU/G1CGG9Ov/R+CQ6VTHPd?=
 =?us-ascii?Q?+31rZIw+UfwghMWmyLH3jDRjgHCeSqNaOY8tBxqSaBrnmMBtSZXkY3aTkW4x?=
 =?us-ascii?Q?PfnQRZxJFuUY/hFvlRYIPFVSdLk5K6KEFRVE5puZnMpWcl0EcdIJ+4Y8nwJV?=
 =?us-ascii?Q?s0I8l9ra3RPxC+IebiEitil+ZVza7euqLoTh6tkO46GSl52sIToFAOzXwlM5?=
 =?us-ascii?Q?3HzwDAlm9oVBb3twRreG4sQAQkTZuGNitvUhlbdwsvN5HJSZ43xtsNMU/tSA?=
 =?us-ascii?Q?QLoQUKXJc+jBrqkOs0dWc6ApXPw+O7ogzIKrrMUnGX8w6y9PFPsxQ6VTiG7V?=
 =?us-ascii?Q?tqdGpTjUm+8fBhKKbdch2151XpYFKvbIvZXOPVd9rERNDhzKITnHHwlgb7Hl?=
 =?us-ascii?Q?nTHb6qq3Ohhp675PJn+uL+wbtwOU/uF+StXxEMnP72WEFgxwcqgYUCOz/mbq?=
 =?us-ascii?Q?oWWMeWoOkz3ENDHb2zKnMrrJR2zQXVgVoTqMjcpcSolpy1hj5iAVYZrN9an2?=
 =?us-ascii?Q?ccOBv22MO7RZBsJnCZSQrUFCzqf7CFw27DbS5BsBP91GRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BinbwrOsz+S5FOsikxk1/LPs2FIgp6EVCqRLYOOp2ZJ7ireJi5RSSVi8hX95?=
 =?us-ascii?Q?8MhpDxSgCUhJBFxjdIUtr8JsUL0hYoBkG+qK27wgevuwS8Ip0Ra7S8NgW8ob?=
 =?us-ascii?Q?K0dcxEGNYzj7uJh/61srMSufLGadHl9JWrLhmXaUXO2LTmTpc7oGYOt9oprJ?=
 =?us-ascii?Q?pUeQDRtiS0TB5y9Be3sBiDhFngJWC2n2r3YzFNW7QO6fGfikO4XevH38lLjL?=
 =?us-ascii?Q?oYi5gka4Yq/n82Kdb7bWllXdZH0F69ESlFkOTjbTIK0RaK5BCz1A6tgp3CFu?=
 =?us-ascii?Q?53n3EJRa/kOUFyztz1V9BiILq46Osw61wm25kDXTLkWtBG1ZuYJWi6Aw7zQK?=
 =?us-ascii?Q?v32g96NG1bwe0n+J8w7C//V7XHwzRdNu3b+x6kpn7sw1Fa8oQJKQo08l3O4w?=
 =?us-ascii?Q?luWSoBmHBqMb/mOxaOK8JAr5yuDPvAUIjSSs0DhFV1dvkyXXTBMT90sCR+l+?=
 =?us-ascii?Q?DaK7kFcdo6jeBmXnknusTxexrF+0Xds5GqXzpR8DtYu3feEHYZMj0P66ZVh8?=
 =?us-ascii?Q?yi34NiUGWdNl82dH/Yh0I+bwM6hIa4EzpQGwPIvo65XAJNq/Lp8j2eA52mm3?=
 =?us-ascii?Q?jqDYUp5eBw2yhBXWUcckcu3bQzS7arj751qNxPBV51Vibb5BLo7t+R3C5lT7?=
 =?us-ascii?Q?iOdh1b+MPxPOYvEzczSoaI4xs3qm3ipMlI+Kr2zUGfEFpPy1vSwv4Ex80B/1?=
 =?us-ascii?Q?yW9iiUdX4UyfDmwTuoJjqjwCYQjnyHzOu/3JdODjNXZwuu7D22mVwfWgOogA?=
 =?us-ascii?Q?FIMAwIo8FckwGRfygoCPk84yvQqrOmkQrszftDy0UiZOYUukg8VMa4xM/lIW?=
 =?us-ascii?Q?+CcupptglQ2Z5oUm1FcRU+1HIvxkQBBMN4Btr7/EreWiA1ldmeEDCHCAo2ot?=
 =?us-ascii?Q?YlLnlaAxHZIi+ZGxMawrTNyktyzysbnEWi/sS86iiDtsZEvG/PFgAuT+6oi5?=
 =?us-ascii?Q?aRfERomNuLkbZvO4w/Z4a8xQ2IdKqNldumjCGG1UUKr3VJLn2PJIoN0AHU0w?=
 =?us-ascii?Q?7o9tR+aoIjBb61GXOkTpAK7XS/fXP+9kP+08r33mZ+LcjFfiuEgywYbN9EXc?=
 =?us-ascii?Q?MMrTqj0qCWpnUavf9hHL2vblJCKY1w2edjKgI9Y2HNEIJ0pQfBSrlw3TiXVj?=
 =?us-ascii?Q?VxMzfkICWkNUdqG5Vg2IsSk+48xjyMQbhku5IMeGe5TBnUXJLMcrj1eZT4tD?=
 =?us-ascii?Q?zZT/O2abEEsBXX8EYxd5gwApWzPL6l0v7XWYN1gwm7ErHDWL4X9VFcZIxXcz?=
 =?us-ascii?Q?9hlKTcHOQvBryCmDFZvc+O+6tE9ZPkmBrR4jpSEKzQVfCnaT6qF4f77S8I2R?=
 =?us-ascii?Q?LI8pGcwjyaKlJ2oWcNGEFJnzn6MSAp5wTIqcCqY4VBHrG8sQH/lG3KTBEpmS?=
 =?us-ascii?Q?OKU4e1GE++F2d+QiKqP2CYicV6VR6W6ejDQg/cJrLHP5d8K+JkQpAqUu7ZjO?=
 =?us-ascii?Q?FJ0hYaqwSvsonIPo2VsDATI1IaRs1/gNH2OR0DCIS76sJNMegF2XeQinwnzv?=
 =?us-ascii?Q?LIHQxzVtR+OZx+pOpVMum2H0B0UDrUvh1D4ZhOgNWpTDowQcoe4MTlPKDNvF?=
 =?us-ascii?Q?9oc4UwUfnDi9yX3/K04nftTJnvAsqmV1gtuDvw+z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea86944-e00e-4609-2a57-08dcc20c9f19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:04.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgLaWeSiP4a0GPUpjrBsadQ0dzLXwYCcEzzkYAJ8uu3DmDmc1HnOt8iiuleNJWyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Userspace will need to know some details about the fwctl interface being
used to locate the correct userspace code to communicate with the
kernel. Provide a simple device_type enum indicating what the kernel
driver is.

Allow the device to provide a device specific info struct that contains
any additional information that the driver may need to provide to
userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      | 12 +++++++++
 include/uapi/fwctl/fwctl.h | 32 ++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index f2e30ffc1e0cb5..b281ccc52b4e57 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -25,8 +25,58 @@ struct fwctl_ucmd {
 	u32 user_size;
 };
 
+static int ucmd_respond(struct fwctl_ucmd *ucmd, size_t cmd_len)
+{
+	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
+			 min_t(size_t, ucmd->user_size, cmd_len)))
+		return -EFAULT;
+	return 0;
+}
+
+static int copy_to_user_zero_pad(void __user *to, const void *from,
+				 size_t from_len, size_t user_len)
+{
+	size_t copy_len;
+
+	copy_len = min(from_len, user_len);
+	if (copy_to_user(to, from, copy_len))
+		return -EFAULT;
+	if (copy_len < user_len) {
+		if (clear_user(to + copy_len, user_len - copy_len))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_info *cmd = ucmd->cmd;
+	size_t driver_info_len = 0;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	if (cmd->device_data_len) {
+		void *driver_info __free(kfree) =
+			fwctl->ops->info(ucmd->uctx, &driver_info_len);
+		if (IS_ERR(driver_info))
+			return PTR_ERR(driver_info);
+
+		if (copy_to_user_zero_pad(u64_to_user_ptr(cmd->out_device_data),
+					  driver_info, driver_info_len,
+					  cmd->device_data_len))
+			return -EFAULT;
+	}
+
+	cmd->out_device_type = fwctl->ops->device_type;
+	cmd->device_data_len = driver_info_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union ucmd_buffer {
+	struct fwctl_info info;
 };
 
 struct fwctl_ioctl_op {
@@ -46,6 +96,7 @@ struct fwctl_ioctl_op {
 		.execute = _fn,                                       \
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index ca4245825e91bf..6b596931a55169 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <uapi/fwctl/fwctl.h>
 
 struct fwctl_device;
 struct fwctl_uctx;
@@ -19,6 +20,10 @@ struct fwctl_uctx;
  * it will block device hot unplug and module unloading.
  */
 struct fwctl_ops {
+	/**
+	 * @device_type: The drivers assigned device_type number. This is uABI.
+	 */
+	enum fwctl_device_type device_type;
 	/**
 	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
 	 * bytes of this memory will be a fwctl_uctx. The driver can use the
@@ -35,6 +40,13 @@ struct fwctl_ops {
 	 * is closed.
 	 */
 	void (*close_uctx)(struct fwctl_uctx *uctx);
+	/**
+	 * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied
+	 * to out_device_data. On input length indicates the size of the user
+	 * buffer on output it indicates the size of the memory. The driver can
+	 * ignore length on input, the core code will handle everything.
+	 */
+	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 22fa750d7e8184..39db9f09f8068e 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -4,6 +4,9 @@
 #ifndef _UAPI_FWCTL_H
 #define _UAPI_FWCTL_H
 
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
 #define FWCTL_TYPE 0x9A
 
 /**
@@ -33,6 +36,35 @@
  */
 enum {
 	FWCTL_CMD_BASE = 0,
+	FWCTL_CMD_INFO = 0,
+	FWCTL_CMD_RPC = 1,
 };
 
+enum fwctl_device_type {
+	FWCTL_DEVICE_TYPE_ERROR = 0,
+};
+
+/**
+ * struct fwctl_info - ioctl(FWCTL_INFO)
+ * @size: sizeof(struct fwctl_info)
+ * @flags: Must be 0
+ * @out_device_type: Returns the type of the device from enum fwctl_device_type
+ * @device_data_len: On input the length of the out_device_data memory. On
+ *	output the size of the kernel's device_data which may be larger or
+ *	smaller than the input. Maybe 0 on input.
+ * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
+ *	fill the entire memory, zeroing as required.
+ *
+ * Returns basic information about this fwctl instance, particularly what driver
+ * is being used to define the device_data format.
+ */
+struct fwctl_info {
+	__u32 size;
+	__u32 flags;
+	__u32 out_device_type;
+	__u32 device_data_len;
+	__aligned_u64 out_device_data;
+};
+#define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
+
 #endif
-- 
2.46.0


