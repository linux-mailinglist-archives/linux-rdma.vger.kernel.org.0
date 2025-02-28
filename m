Return-Path: <linux-rdma+bounces-8196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38FDA48D34
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899AC16DABD
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03096B66E;
	Fri, 28 Feb 2025 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbgp1oTG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E24C91;
	Fri, 28 Feb 2025 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702406; cv=fail; b=tE5s8C+lPw5h58LjG3GCf2oKugOHFPJ0CckqLhhydbKU2z+zkkQZRPhqJ8YeqRPS46TmJK5RkNPQAxkIVpjryhQmqZPJT6bXVzXA8BkI1ypgyEtCO1g6McPasK+H+3yWamDD1B513XU7R3HOgYuPtnwL52Nr20jz31sHj4P1XrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702406; c=relaxed/simple;
	bh=LKxZQyrVN34DZMe6dZVbZCwmfsS/Iiz0nU9NI5x+Erc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWC0LGS2yyhHMvU1zHq5K5fjPwQ2StytbRHfFdce7UoZ+w8zPecsQiXdZ7RySmCoyYuty72Xmi/QYynvLcnZnRZPJBmVPX1sp1DYV08lssAQPBBvJhrGbyxxtCZ3IcwcpPBeLksivza7my3RMk+Yz2Bhzn2Z94zJe3MVtMh2PNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbgp1oTG; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWpHFi4cn3sJ2jCCQp2GPE6KawO3ZVxS8gdc3NM2V7BHMPPpoaJHXF04EFDBEJdmKEL16k64iJPFO51D8vw9Atm1gAAImmtTMSJvgaEJmJ99bw/mLSISHRypRwa0q+GUOf6zyN2Mkf9KWwWRruniY6jyII7d+GaG2XQVgefCggcjep8RPoN3zxKf1lIaO/zqvTHl1NSexF941/6PeOQ2MWy2BcJuJvFXw2ulzulQnq+H9FN40eY78XO+KbRXhoiWlb+x2likJSYi3zn75doBQNkYfl9LtJtEFewbrWXROKq9ZbthThI/VJZWLj33116Kyy4fh1qrN+OrQxY6UXFfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkBl3brbXgBSK3X1TI8MK8YuByvDKrvBvPLkNQwICkM=;
 b=GnPNTxEhpT2W7hBvKSvCjDMDgztdO4khSyD97dC3r2asLNFVcBrEtyCyYhH4YTAcrgAc2W/vD/z4MdGUXleVOlExVA/Wzj0bq2FQyBYH2gwUcK/+tftjgMOl8h7zi876NfqqjdtFigd/OS8MooyiZ6kpz+oOH0ug5bpEhSGZikdHOcDbznl6KafUQSas0NKWpYZSybDsc06t7J1Z58M+trvbWBryxO6FQ0b1fE8Tu8mligW5sVy5qBgUgucPtyQK9z9kXotuTHeFn7kavURIjaVwBt/OT/fy88002IB1R3h6HASyJaxk4tGMLhx7T1P+1SEDMZTGEmog7zhleV0bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkBl3brbXgBSK3X1TI8MK8YuByvDKrvBvPLkNQwICkM=;
 b=pbgp1oTGuJQqxV/rj3WKuDRLyGNY5AJNqkimvPPyhScJGuy3bElDEAu+gI0pj4zJ2tBQk+dwT/PUlitM69MDDvyfaGGcGyPlZ9QdCI4L8koSfFQBoFTaIOTfJLYEFrWPUub61c57wLn0msiu7WgYQFXIBAchr/rI9cYy7YM6XCO1931RICTyMUb55Ip8yCd3sUZKioWMxTLA3i1NAz8XGvKeqjNonx4zZ79sj39CQxMXDKz5jwpCjfTe1qS52sz4bKNfC/JPLdKTIyK7D0rodqdony3QGpFPLraDJBZIrAXyTXY/EGhgdiAnehOiTWPA3WmWyC/pUAVsNMjsMnsfrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 00:26:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:40 +0000
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 5/8] fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
Date: Thu, 27 Feb 2025 20:26:33 -0400
Message-ID: <5-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:408:ff::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: f0aba336-9f13-47cd-2a9e-08dd578e90ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67EDC5QTou2Ea4URybx55QTEa/5iXHdqqCEa9UpqDb7RUoi1spev0TN3d9ak?=
 =?us-ascii?Q?vH3yhWLPa4YwOcWTLNb3TIgfLQSoDev5pugajZ3CmgXXPpIJzKf54APGZUsm?=
 =?us-ascii?Q?e3zc3PP1Ggu8y+DRveonhawXMSOy8RQgKN23s1H7pjacmN+en6Dgzh6CKLZI?=
 =?us-ascii?Q?4++BIg9aPHvIM9ac/GyjBm0iutPirZR1LWVWWJDpDRvQEWMcOPJcBl+IrsGR?=
 =?us-ascii?Q?9xJL+yLder9AI1Qn7qBzcWvmRo7NozhZ3/krK1FPdcXgPxDFgMBnOMU2Q+KA?=
 =?us-ascii?Q?qPmgMToVOHjwwtm0FtjDdZqeX+QNXW4ABewKImz//2xlmr1BrDyb3bp8scmm?=
 =?us-ascii?Q?w/XoUQrgE+XIjKY8ynB6rHMpf/AJDAPRWuYbrpCoNu7+rH5MyoI0XGGCD3cy?=
 =?us-ascii?Q?SEn3o2a86+UTXmQbCYIaH7AL3TXnlKJZ+Wn1dbid091y8Wymyh1op5FdXEoA?=
 =?us-ascii?Q?flJ0KpKBDsR6nk23OqFW5+B/M0C3opIg4qyF0yDZweCalnimRTAl04z0nDhi?=
 =?us-ascii?Q?jeZPMJaoZgf/LL0hv/Htfm8wpJ5ZfCIYaGT54X4HXgX/LRDBrIFOL0JZDghM?=
 =?us-ascii?Q?twdBX8G6u9KqFLiDcmFJNa91OEmYTkayNr4KSdY7zI6FkpIqh2zNpAB/R+gY?=
 =?us-ascii?Q?3BeMUfDuZfx0QhFR32Wfjz02VU1aTCBN+n9yhn/to3i4AFXdgb+Towps6OTY?=
 =?us-ascii?Q?b0U4pwIOzqL2MHfXDe0NBQlUDTH05Ftps7s71oq0KJ5gnd4TsOCg6FPox0lJ?=
 =?us-ascii?Q?RZQe4M4HT15k+4G9eRhB1mOvOxTmCfA4ankY0qkRlFYLcpDSH0zsDlE5SPdg?=
 =?us-ascii?Q?s7PXE29Isaw7p1BC1943jijOAZdt1Kk9IdBJwEY5+Pg8tPx3jlzoiITd/qal?=
 =?us-ascii?Q?F2KAKEihxTQT0zlkNsaoG3JMH4QcuFD5EgXSLmjo1QIF/be7kqyDc/8mLj17?=
 =?us-ascii?Q?fLEdu36sDfFW3g4/dNkRnT5AZ8DyL+0fXDGEa7ubftJMzkS8AcSR0OeDx2/A?=
 =?us-ascii?Q?VoI8Ag5WhO9R0Mmz3DulJOLpWUDkoVAWraVaL3g+VbkPbywyEE43I/hQkFVW?=
 =?us-ascii?Q?AQs6BJUVaUuJDc/KE68qbJQMPIe0lZ5+BnxCPUHJv8TrZqeTQO6f+kP7Ww/X?=
 =?us-ascii?Q?JV1G9cKDAOIVtZ9Zp2C2fdGQXzhnKID05ass7VwtLOQx9P4d4rc/iTp2DT4k?=
 =?us-ascii?Q?KOyGSrbN9xioP83asB+rC9gGZg0f4qFsQRuIjg+KWz8gMMEcx0PJw3nt2Xpe?=
 =?us-ascii?Q?k2xCttGX5orA2mXqV55QKk/CVPVYb/YosPJoObTPbQs1HKGsKNN/ubLhd7kS?=
 =?us-ascii?Q?12YPORIwbtL25PVWfobzV2LnBowEnyt9Z2lBHoAXihRoj//U7iMyrihRW/nI?=
 =?us-ascii?Q?bjfm3vmk3UikzAWrUflaOixWnASt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hcCysxvV1jaYbcEY2gWM2wLDvLeRjAdXxC9JP+N3KmMtOfMiwP4gCQ334+j?=
 =?us-ascii?Q?zZObvYVtlcV4MVbnf3FqQXB3AAzfC/7DOTv5a8WUFwFV9OotocEjygVlN04H?=
 =?us-ascii?Q?g2WNdZHE3oILEnCcqn5JTgx61Ubbv7Xb6v2X2VIHe2rD5fTD+h22j9L8Yo6n?=
 =?us-ascii?Q?6C4jMCOYzliVG0bGxYrXK/RLHB7XvnwYsccZlScX5cyt0aF1thVe2rPCSMyg?=
 =?us-ascii?Q?jDbjetMY7kjOIgBkLsuAgJX1h+ZDqY9lZk9cDM6DipZdMsdwqh+4cSmEwi9Z?=
 =?us-ascii?Q?peONQF6+FwrkY98fSs2Yy3UVRnbCH+6sR1EtISv/Od/aOQD3rCCAKnK1bI7m?=
 =?us-ascii?Q?HxAPIhBG1A00k/ueE1O3RZBgV9gtYRAZ9O0+QxnJMyoi3pJ5Uo+4XYyKiB4c?=
 =?us-ascii?Q?owGMeqKZk4aTAV0WRpKacqucTKOcs3VBWlH9MLhkByWs5nAL8eDXAS0s69pT?=
 =?us-ascii?Q?Y5ZFCbcXjx8DFPjaHnSP2iAHMyoXpld+dlCQz8ApDLHnt8qWLQoo/hi5YccP?=
 =?us-ascii?Q?ikK+bVcDdkubfT+UAQ5zCbbSUXNdxOv1rZIyHvCDAKJvdW7/IQ5RhAn+TPB+?=
 =?us-ascii?Q?I6WD8n1CXmlgXUG3TgqnOgmNneOM1o53jsuXXGGgW3rI34fVjqiZTUn+JlrD?=
 =?us-ascii?Q?26NiEE6bh28Oy2aOWuUnI4D8upYn47tpL7rH3C5tgb/ZCNoauL5/z5Y2CCC5?=
 =?us-ascii?Q?23Wx5Ss+laM03D1ePtSgTVtEGENg8y8so+gomfOZu9tzzVsHLuUPtrm10Rkn?=
 =?us-ascii?Q?4ajHHCyPGd/8YGLa9PyF0MlHNlebKlX8mkPcQWD/43KVgqGmdMsk0EYIDqyX?=
 =?us-ascii?Q?YZs+KaBQC7XeUOewe/EDkW8DjPwpXrMAd5PlQUGT+SbVHZh+iuFlQyBWmgSa?=
 =?us-ascii?Q?Mci8kQNHIwImyqKxJxdBIRt6rMe4rvUn05d4Xvc69MWP8KD5+eDtr05Tc7Y2?=
 =?us-ascii?Q?zfJ05CMSUgMugn0tyWHv9uo/bm2R64cNKkxbWv2Xt/WR+8KcKrMF7To/DuiJ?=
 =?us-ascii?Q?TSzyAc3uofqQcnSSoi0H2dZ65+bnk7mPLhN/kUFtk0eTFb4dKTQsCVTm0LWp?=
 =?us-ascii?Q?Iuyh6FtoBXweSD8ehhn6WkIyWTU1ICvnnDnKqZrZb4rai9gAp67SFEZ+oLj2?=
 =?us-ascii?Q?63QssYjBr4jkD1nVZqTEC3mJtZyA23MmoKHQvTSokyt6kn/LXUPZ/vpH04CZ?=
 =?us-ascii?Q?enER1GgSPmPOM3U9rPWBINnU7Ktle5NOPxycVj/cPun19mHT3hbXcCnLK92i?=
 =?us-ascii?Q?gtGcb9F/LzQ5TZAzROHJZXyQXv7LgOw3PZWE3N3Z0MZ5v759Rq7xa+ucaKSt?=
 =?us-ascii?Q?yfGcNnCP9BynAx/lyXIbyxtmKpXhZxzgloMo7ZGuE4pPgQU4/o9+LhA9xxCQ?=
 =?us-ascii?Q?NOyuaTZM6XkVtIAULOWl2OhP0j+9ot0q5uNcxuJpykJZy3kp5feIee2QQo/x?=
 =?us-ascii?Q?yoI/0Vtn96HL/zxuB9uurgq2oxuKYheVb1R3rAFxJw3gMJXmdHBs7khE4fNS?=
 =?us-ascii?Q?mNZy8Eun2Fkk2no17VD9OtYX2b8Mo7GwDKo/HHGRQholVo+7OHwIfVMjDMt5?=
 =?us-ascii?Q?c0BZnsnYRD14VqcoRqsWtF3SBEkpV2tRJElJDAyO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aba336-9f13-47cd-2a9e-08dd578e90ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:38.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufjQcp20W7T/fAxNuvqA0/yDrBYTrieMnBQzNB7OI8Vcd7n5Bpq7YXfQtCsank5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Add the FWCTL_RPC ioctl which allows a request/response RPC call to device
firmware. Drivers implementing this call must follow the security
guidelines under Documentation/userspace-api/fwctl.rst

The core code provides some memory management helpers to get the messages
copied from and back to userspace. The driver is responsible for
allocating the output message memory and delivering the message to the
device.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 60 +++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  8 +++++
 include/uapi/fwctl/fwctl.h | 69 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index bd84c4e5b3b92e..cb1ac9c4023938 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -8,17 +8,20 @@
 #include <linux/container_of.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <uapi/fwctl/fwctl.h>
 
 enum {
 	FWCTL_MAX_DEVICES = 4096,
+	MAX_RPC_LEN = SZ_2M,
 };
 static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
 
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
+static unsigned long fwctl_tainted;
 
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
@@ -80,9 +83,65 @@ static int fwctl_cmd_info(struct fwctl_ucmd *ucmd)
 	return ucmd_respond(ucmd, sizeof(*cmd));
 }
 
+static int fwctl_cmd_rpc(struct fwctl_ucmd *ucmd)
+{
+	struct fwctl_device *fwctl = ucmd->uctx->fwctl;
+	struct fwctl_rpc *cmd = ucmd->cmd;
+	size_t out_len;
+
+	if (cmd->in_len > MAX_RPC_LEN || cmd->out_len > MAX_RPC_LEN)
+		return -EMSGSIZE;
+
+	switch (cmd->scope) {
+	case FWCTL_RPC_CONFIGURATION:
+	case FWCTL_RPC_DEBUG_READ_ONLY:
+		break;
+
+	case FWCTL_RPC_DEBUG_WRITE_FULL:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		fallthrough;
+	case FWCTL_RPC_DEBUG_WRITE:
+		if (!test_and_set_bit(0, &fwctl_tainted)) {
+			dev_warn(
+				&fwctl->dev,
+				"%s(%d): has requested full access to the physical device device",
+				current->comm, task_pid_nr(current));
+			add_taint(TAINT_FWCTL, LOCKDEP_STILL_OK);
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	void *inbuf __free(kvfree) = kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT);
+	if (!inbuf)
+		return -ENOMEM;
+	if (copy_from_user(inbuf, u64_to_user_ptr(cmd->in), cmd->in_len))
+		return -EFAULT;
+
+	out_len = cmd->out_len;
+	void *outbuf __free(kvfree) = fwctl->ops->fw_rpc(
+		ucmd->uctx, cmd->scope, inbuf, cmd->in_len, &out_len);
+	if (IS_ERR(outbuf))
+		return PTR_ERR(outbuf);
+	if (outbuf == inbuf) {
+		/* The driver can re-use inbuf as outbuf */
+		inbuf = NULL;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(cmd->out), outbuf,
+			 min(cmd->out_len, out_len)))
+		return -EFAULT;
+
+	cmd->out_len = out_len;
+	return ucmd_respond(ucmd, sizeof(*cmd));
+}
+
 /* On stack memory for the ioctl structs */
 union fwctl_ucmd_buffer {
 	struct fwctl_info info;
+	struct fwctl_rpc rpc;
 };
 
 struct fwctl_ioctl_op {
@@ -103,6 +162,7 @@ struct fwctl_ioctl_op {
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
 	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
+	IOCTL_OP(FWCTL_RPC, fwctl_cmd_rpc, struct fwctl_rpc, out),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 700a5be940e365..5d61fc8a687186 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -47,6 +47,14 @@ struct fwctl_ops {
 	 * ignore length on input, the core code will handle everything.
 	 */
 	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
+	/**
+	 * @fw_rpc: Implement FWCTL_RPC. Deliver rpc_in/in_len to the FW and
+	 * return the response and set out_len. rpc_in can be returned as the
+	 * response pointer. Otherwise the returned pointer is freed with
+	 * kvfree().
+	 */
+	void *(*fw_rpc)(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			void *rpc_in, size_t in_len, size_t *out_len);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 4052df63f66dc6..0bec798790a67a 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -37,6 +37,7 @@
 enum {
 	FWCTL_CMD_BASE = 0,
 	FWCTL_CMD_INFO = 0,
+	FWCTL_CMD_RPC = 1,
 };
 
 enum fwctl_device_type {
@@ -66,4 +67,72 @@ struct fwctl_info {
 };
 #define FWCTL_INFO _IO(FWCTL_TYPE, FWCTL_CMD_INFO)
 
+/**
+ * enum fwctl_rpc_scope - Scope of access for the RPC
+ *
+ * Refer to fwctl.rst for a more detailed discussion of these scopes.
+ */
+enum fwctl_rpc_scope {
+	/**
+	 * @FWCTL_RPC_CONFIGURATION: Device configuration access scope
+	 *
+	 * Read/write access to device configuration. When configuration
+	 * is written to the device it remains in a fully supported state.
+	 */
+	FWCTL_RPC_CONFIGURATION = 0,
+	/**
+	 * @FWCTL_RPC_DEBUG_READ_ONLY: Read only access to debug information
+	 *
+	 * Readable debug information. Debug information is compatible with
+	 * kernel lockdown, and does not disclose any sensitive information. For
+	 * instance exposing any encryption secrets from this information is
+	 * forbidden.
+	 */
+	FWCTL_RPC_DEBUG_READ_ONLY = 1,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE: Writable access to lockdown compatible debug information
+	 *
+	 * Allows write access to data in the device which may leave a fully
+	 * supported state. This is intended to permit intensive and possibly
+	 * invasive debugging. This scope will taint the kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE = 2,
+	/**
+	 * @FWCTL_RPC_DEBUG_WRITE_FULL: Write access to all debug information
+	 *
+	 * Allows read/write access to everything. Requires CAP_SYS_RAW_IO, so
+	 * it is not required to follow lockdown principals. If in doubt
+	 * debugging should be placed in this scope. This scope will taint the
+	 * kernel.
+	 */
+	FWCTL_RPC_DEBUG_WRITE_FULL = 3,
+};
+
+/**
+ * struct fwctl_rpc - ioctl(FWCTL_RPC)
+ * @size: sizeof(struct fwctl_rpc)
+ * @scope: One of enum fwctl_rpc_scope, required scope for the RPC
+ * @in_len: Length of the in memory
+ * @out_len: Length of the out memory
+ * @in: Request message in device specific format
+ * @out: Response message in device specific format
+ *
+ * Deliver a Remote Procedure Call to the device FW and return the response. The
+ * call's parameters and return are marshaled into linear buffers of memory. Any
+ * errno indicates that delivery of the RPC to the device failed. Return status
+ * originating in the device during a successful delivery must be encoded into
+ * out.
+ *
+ * The format of the buffers matches the out_device_type from FWCTL_INFO.
+ */
+struct fwctl_rpc {
+	__u32 size;
+	__u32 scope;
+	__u32 in_len;
+	__u32 out_len;
+	__aligned_u64 in;
+	__aligned_u64 out;
+};
+#define FWCTL_RPC _IO(FWCTL_TYPE, FWCTL_CMD_RPC)
+
 #endif
-- 
2.43.0


