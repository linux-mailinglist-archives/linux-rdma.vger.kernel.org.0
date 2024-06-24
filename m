Return-Path: <linux-rdma+bounces-3462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C719915A16
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD53B22854
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967E1A38D3;
	Mon, 24 Jun 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kv5uJLlf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5921A2556;
	Mon, 24 Jun 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269270; cv=fail; b=ptia3Tsy17khtCsOy7FBxK7YAoK438UFGb5oKWLIuxu64TevgWqmVnJmpLGRkXKt9rHLPgO52fvAW1U4SoLCtSohMs504SXbTlG5zgWdvwBFmtMS3V9TJprqoWcrfPIKcHcb0o0PPvotcZO20H+oQ32Ttvv7xr/Wm77mwandBWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269270; c=relaxed/simple;
	bh=xNTNqHqZ1cG9cvVIU83R7MWCqKHpanuuBkyZ9DSwFUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfj/5hY0TxfOLu915GDRBkuRLLVZb/iz+u7judOaRnabIMiS63kqA59XdOU2JPVvoYfBYj/3LjSw5zwDcF3R8MqoctcsmyWp5GQb7INpEYRJVN1Uxm2mgDN3elcJiBnJsLYifeO+2xdDsFMQiceNz1/ovb6E2AP3KIC9EREu0CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kv5uJLlf; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+dhGEGBogjJIO1lSN9H9K3Kydf9Y6v3/txNaHXLs3DdCFuFGg4UWLY2w5/35pfE/jj71eNoPSLq41SSwIncjtk3DJcGK3Gy7JV/tUoCskAWQzPOENbj67PwvHub0M9dmIuP2fmQfFhaQEGYqFVlaHztv1zo1IhCApI0zZBQS2avo4yRDA2sR8P5YMw9J7WWC3LVmbonBAHwlYMRmsen3g7UuFg9Up7yCkHOmbvNLoStR1YEEcoEQojaRWakPiViiPil1Kik3FmLQFgYC1Ngvw9Vjtli9Uwwm0wU3co1pYrJx+VTynZoBTPLfTbjFd9+jU+P4T6vMEJccZVcFl/XmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LkXHMOLTxsLzvj6tVxRa5+wTgzmi3dZW8K+OEZv8So=;
 b=HRFi5XSdph2GNcFUpQwNx1aJKCuiL4NkeJoOc5IEVRiXMZ3tSUOD76PAh7rU8gWUE/e1+Pu05UJ4E5vAlQCJj5cQuSoq5iSqRwovbAOSNVpLlxD/0b9bi82EoVTgMc+cmlqLszoj8lCDp5rycoEClyXE8e9uRza1cJzKIyfFMye9DnGSsnyyWTag5lUUnjj+HqVhN3DAzbWnxn58txBxB9aXXir/FHc2iO3Eyhq9NL0JlkOhZ37EKXuZ5oqQQ7Fjbf/egS2hc13bSn92BawN17mfrH4Hb1tiTZUAYcrQ7S+bPWj9F/GAeihFmgDPSbUz0Ip0q/A5YuVgYtL/QAhW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LkXHMOLTxsLzvj6tVxRa5+wTgzmi3dZW8K+OEZv8So=;
 b=Kv5uJLlftwnhfOBozDZs4is63FoBfD82PfKkPv9XoIJ+tAzlqxsNA34EczwGOMY+9Np5frGecm3YymNpLIYti9O6ibWOKJcvt3GIgDQwk2IUFk4YcnMtCZQmsgndKGHc+z8gz0KhXlQcPF0bANqzvHaiJ5x33RYnRZzUyEQCsBx2HKYXeawyXKbZTckapfUTjtWjJVWP7s8G+SJ/aRiTjDzmQFJvRYlRIHiZ9MQ84K9XjID3JMofe4Klz5f7tGwOzMJu1/oTnTKah3OjIDfoIar3Bg6m7p4oNQWFxbVXG4CYhRxc6obVK+kh64lOjP1v/sv9lIu/PvGQHyU8iKYbMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v2 3/8] fwctl: FWCTL_INFO to return basic information about the device
Date: Mon, 24 Jun 2024 19:47:27 -0300
Message-ID: <3-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: dee19c90-208b-48b7-c16f-08dc949fa3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VX0qZGfzpGbOvhUZ1bsvpoSVytS+feUo8ZO/50PzsxBp36BbmlRu4x1rA30E?=
 =?us-ascii?Q?uPvln+OeZyIhNYLcGBT+oj0l2aikLEHklsTcqczMC6hr+nldzxlrGhA+8/Wh?=
 =?us-ascii?Q?wB0pi1vCc69+y+qhjvpC3jUBdBxf+fyXdMHQbiFSHga37pzLq4T5AuF3p+dK?=
 =?us-ascii?Q?WecOdEoUILlOYQOP1a5cdIQbHOPQTuJJT/cC0USXbdzoX6hVzC/Wd1TKq5i8?=
 =?us-ascii?Q?1jUkh4tXFetzrvRqtbFWYvLeOES/d8Hq5qUohZ1N13cjv9hI39ebjkABoo3f?=
 =?us-ascii?Q?mmRbuBUO5K8EsjnjZwTdEbODmzkgE3q8DoonHsf2ynC0n1uEwqQnG/AR6Zfn?=
 =?us-ascii?Q?35rAGxMW20MZDD3M3AO5in/KGFS/bwXnsWZE4xqNemU7tiYk0VXpwTy5uiLk?=
 =?us-ascii?Q?CHP6bpr6SCKPAdWUZQRlVTIEi8rEO0EfU8XI+VFBEnVZEXun9od4a0i+r/ap?=
 =?us-ascii?Q?WNvASmElBrnHE+rNRnUXHwsyuqQv5YRxgLsNy6yOyhCZGBfQurBK43OMaiRV?=
 =?us-ascii?Q?AvolRRE1KIUtT1LTaxLtxH9P9nydiTjCcetqwkjOK8ea8MVp8ooQp3NqihbQ?=
 =?us-ascii?Q?LGAb/s4grrJumbX7rFlPy7NB87msQub0egPAmE2cXJ3HdpSvk7kdXlsQzZ6/?=
 =?us-ascii?Q?aBDecT33DaSKoOeBECB0XVJhVnsN3tMvKPmzBcVqy6b//jUH6lRK9zYyynyz?=
 =?us-ascii?Q?KLdfnHjCw6WR3Cxhxu09GhFM/tVZMagEhMA46d0FXID2Phal81MJpMU3cIty?=
 =?us-ascii?Q?FJxR3kFxe0T9SIagFQGX51Eujlg9liUSCimvj+PmN3sKlrOQIwO5z7FfRk4A?=
 =?us-ascii?Q?oxxRPFg2r+omq3OpBjhQu6SIUVzf6IkfUeLQ2Vnl8TQoTeYre22asOsJpqnx?=
 =?us-ascii?Q?TrAThTlOI7tirWG3QB6ogQw4R3BsrzqpkeHzo5ydJ5xCNHSTrIvzP5VPKaOo?=
 =?us-ascii?Q?DnPrhoXUtDhpP0wnBnAoG3cSIWv/o3VziWBP7F6FBOC+LnNP69jEpZEHGRm+?=
 =?us-ascii?Q?9PgQHmeDXpT4J1wZ1gRahgkuQH0lw0H0iJLIDNlx2CCASKWT2wPpSfRaiMQM?=
 =?us-ascii?Q?sMp2e3jSA5RJIGc5b2GSqAXXF+vaJj7VWpjUt0rmIDNcgxZIHldfZRt4gIO2?=
 =?us-ascii?Q?bi+T2t40ON+2NPI9ImjXt4GLiaaAaxfYj29QYNNx4gBte+1kSFE6aB6/0S27?=
 =?us-ascii?Q?COn3px9j97mg7rHB1l5so3nzk4/P577M+XhinP8mfpmK/IqsRUBteX0VGCkc?=
 =?us-ascii?Q?Ssp0KSfN5gqkoWVEPUhcYq14i2SU/t2WCD/PqOaOcy3moXKssCS38BXjShsv?=
 =?us-ascii?Q?Kn9U3rJkSYS8QEA2q8sv2JFuBiMxZnMsqyjM0epGPXrTpjMnhG4dUkeGh28V?=
 =?us-ascii?Q?lcjHWQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GyCLSz2xSEJDvUIuP1/TcOLs3p2MVFbm2MeAoKYTcz5wJQPC8YI6buIXAjRn?=
 =?us-ascii?Q?mA6LwWkvWif5ya/IcnZeQihplPjtb58WXUOoW0VefjRRsweqSTudzdzln3EQ?=
 =?us-ascii?Q?/rqqj2FrBGCb/EzxNH/2l+WnrhuvkVfBVunN6vvkRbhNanZBO1HIigDJ/8t5?=
 =?us-ascii?Q?OobEI3pq0/EhcE/yRi9UoLzzjv+VSyZMLrQgC/V8aTlMIZTE1mBWCVwbPj02?=
 =?us-ascii?Q?mgOlsFlGVicTxWwKSN8VkA0dil7ubhA6gGmTPWJiE4oDDykdqolE55vzYMQw?=
 =?us-ascii?Q?3AmUwag6la/s7H0n9gdbGBz+ff+ZTMAU2ORDR7h5572Fg+aHtlv/6wt7Nkpn?=
 =?us-ascii?Q?l4IUGPcSYGHsl2fCEhc3gXeN/f+4PeuAJMDlyIT0+y4QOUMozHtSmz/DkwwV?=
 =?us-ascii?Q?4N0/gDW3cwmcwVnXlBOUBfG08M5P3f7lkNYFa7xsn/SHv54jWGtDce2ylLbF?=
 =?us-ascii?Q?qV2ZSuHuMGAfkyPDkRBykFTNuu77EuBt975TRxDK7J6brEIplS/IAEOH25BL?=
 =?us-ascii?Q?Bgkuj9hx9dO7Zrls/BGCKDQMfM6NADGxmCEXXgcVhwb3ZseTmsZuM0+RCHj8?=
 =?us-ascii?Q?KhM45iHTpedQr5mOezjUTOweW6Bx9W+EDfv8BbTi6Q1X0LgV9oqS/l8XrCK6?=
 =?us-ascii?Q?yntE95iHMipAC9dzbIynpkKI4rPldhAmNa1GbAKQrLDJ0nfofOaFZBLo7goy?=
 =?us-ascii?Q?4h8z/oBpQyNE9A+lYhPqNSiIlU3yZlDFsMymw2dwHzTXk/LTX43tWwVhIwa/?=
 =?us-ascii?Q?17hNUAoythXG7yPyij8gp9NSF2WuQFZS3KPv5xqqZ+4/aCIpGskYo6FPk+q+?=
 =?us-ascii?Q?Mikj+C+lKNW0DswalLt6m2Kbcl/bvIlg39v67JnnpVwswn22Ij47dfUN/QoI?=
 =?us-ascii?Q?1UNNVAuqmIR1pAYPgG12enetqMwpPQpzFyVhXRDYJatjdKO1VMdlkp92TDCF?=
 =?us-ascii?Q?xBf//Rhekq/HiW7K/3m7Ok/Htt3/AR3DUbq2Omhp9C/g3SznJLx/ywAsftph?=
 =?us-ascii?Q?9YrYgvoOFjsNiYybw5TkKDcTNJ5IPECOjLX4iRa2jMAOGKI9HSgProhlhjhF?=
 =?us-ascii?Q?0V9gWW5j4tK1vIXSiMs5ho+TLakKSm73SzSVKJy7+smvcow2231ulnUpy9sw?=
 =?us-ascii?Q?YbTLNO3kza0on2Fn7XvCXGsFgRvY474FvUKjdo3pTyfe3EaA2VsPUTcqjD7e?=
 =?us-ascii?Q?t5P71WppCptptKctHdyjBUc1Iu/7M/V7phcT1Dvvc8evCOSbFg4sqa7QgO2y?=
 =?us-ascii?Q?YDWXtb0/eaMnNpKpWx+iHf44oeIJYmeamO2WANVBQqVWwMAF5ezdFilOIR/s?=
 =?us-ascii?Q?9OFNPkLh+kG3Bsp6o2Oqx2XjTtwlkd8St7pjweSOFrc+3Hb+12zgrMqV90cK?=
 =?us-ascii?Q?pEhpLYcRSdY5LcwMN0zLzDDON1XcoKz/z+9HweDDKTsSx52dyVuw0o+hYKw9?=
 =?us-ascii?Q?iTxqIWltwzhJVCOsRsTTNHyRGwmt8Cqvt6wADiovQxdoAkePcYz+ZWKRT957?=
 =?us-ascii?Q?XUKbxDXhvALPXVHfo4kc1BHjYNxHfUI6SeLW+OJTjD5tQpeUZvKEjayaK61O?=
 =?us-ascii?Q?/yU8SAKEAgmfuvWvH2Djp/bUj4QnVR3n/FGkDaf2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee19c90-208b-48b7-c16f-08dc949fa3d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:35.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c3tP5iWa1z/0nJbEZB+djCunc55eBMKZw7ROdmTD6XwGiIJt6kI4xCgWdJNg4OK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

Userspace will need to know some details about the fwctl interface being
used to locate the correct userspace code to communicate with the
kernel. Provide a simple device_type enum indicating what the kernel
driver is.

Allow the device to provide a device specific info struct that contains
any additional information that the driver may need to provide to
userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/fwctl/main.c       | 53 ++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h      |  8 ++++++
 include/uapi/fwctl/fwctl.h | 29 +++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
index 6872c01d5c62e8..f1dec0b590aee4 100644
--- a/drivers/fwctl/main.c
+++ b/drivers/fwctl/main.c
@@ -17,6 +17,8 @@ enum {
 static dev_t fwctl_dev;
 static DEFINE_IDA(fwctl_ida);
 
+DEFINE_FREE(kfree_errptr, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T));
+
 struct fwctl_ucmd {
 	struct fwctl_uctx *uctx;
 	void __user *ubuffer;
@@ -24,8 +26,58 @@ struct fwctl_ucmd {
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
+		void *driver_info __free(kfree_errptr) =
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
@@ -45,6 +97,7 @@ struct fwctl_ioctl_op {
 		.execute = _fn,                                       \
 	}
 static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
+	IOCTL_OP(FWCTL_INFO, fwctl_cmd_info, struct fwctl_info, out_device_data),
 };
 
 static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
index 1d9651de92fc19..9a906b861acf3a 100644
--- a/include/linux/fwctl.h
+++ b/include/linux/fwctl.h
@@ -7,12 +7,14 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/cleanup.h>
+#include <uapi/fwctl/fwctl.h>
 
 struct fwctl_device;
 struct fwctl_uctx;
 
 /**
  * struct fwctl_ops - Driver provided operations
+ * @device_type: The drivers assigned device_type number. This is uABI
  * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
  *	bytes of this memory will be a fwctl_uctx. The driver can use the
  *	remaining bytes as its private memory.
@@ -20,11 +22,17 @@ struct fwctl_uctx;
  *	used.
  * @close_uctx: Called when the uctx is destroyed, usually when the FD is
  *	closed.
+ * @info: Implement FWCTL_INFO. Return a kmalloc() memory that is copied to
+ *	out_device_data. On input length indicates the size of the user buffer
+ *	on output it indicates the size of the memory. The driver can ignore
+ *	length on input, the core code will handle everything.
  */
 struct fwctl_ops {
+	enum fwctl_device_type device_type;
 	size_t uctx_size;
 	int (*open_uctx)(struct fwctl_uctx *uctx);
 	void (*close_uctx)(struct fwctl_uctx *uctx);
+	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
 };
 
 /**
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 0bdce95b6d69d9..39db9f09f8068e 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -36,6 +36,35 @@
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
2.45.2


