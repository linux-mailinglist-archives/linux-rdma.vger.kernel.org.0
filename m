Return-Path: <linux-rdma+bounces-2913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C08FD67F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6520C1C22A5A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B11152DED;
	Wed,  5 Jun 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="Myi75pSZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D714F9E2;
	Wed,  5 Jun 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615819; cv=fail; b=sSGuKnbmqlRZco5iNh5csgFMRJxNvPrgAeQwfUCU6NI0nCU94Qr8TQ4UjfPnxCxmOkBxI4nlaBAzyJBiu2P2V7yfaLx/MqiK9onM5rCTgpO/3PzJd4dfVq16lh88gf4pGH47fuIzA6wXPJ4KjFhv42YlckDJeB5HUGxwCwmUhAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615819; c=relaxed/simple;
	bh=8W5nGv/3FT6rSUcTLsAUsYjbMKa6DPmS30/tjUC9gGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEiBZkIBY9/bxuvQgl7/qhoBZCkGvQlV898SEBa9wSAki7nVqR5ag3PJ5oXQG4cMzOg3XTSKcg7uXJkH+afiilN8tvrdpVaq4A2SXKs8PywjZHCBctUt8JTbrkYTDpQXqbJj5pJT0rlW2ZLUhTjexpvBeH3Dtsj3d+xmOq6aENE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=Myi75pSZ; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLGYPz+RBH6dfp8xqYoeUeBBj0Fwb2xXTdEJsVPC7HGOCMje5Y9YsdY9XaxBPG4Nlo8qmXEfsNRf0Bz7OZ9mr28pUjAeQvAY0h2xRao+RXtuLk1pKjnYArflrxVjpH/0krlkCbsmeqgTk5IneW2e40X+i/kopMYmilQ+8zenwjr5lItCif0g205fivAyMMpb6KVSf6hMAW9wLoCJQR1jExw5eXPOV560HDDyVZYAPCpvBeFR3yj+nkb3DjevbIIgq9WcVCTP5TgFnlOY8YzxWc7hgXgSLfXUslAZWkZYFo2bTWHmioHET2bEyUMkcmC/e2SOo2T6WUgRST4h4m+l5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK7cpODuC2vrnu2LI2gP1Gpl8QQ3tT8dvcO1Znjx7OA=;
 b=LZwTGCas1onbv5Bgk3wmvlvl2x5bILYPJmdjdB2u33e/KBu7PtX+grWjSugNKMofuD1mXu4i/45CkBwCagbGSc54y571au6bccvt+uhOX/n4pUhNlGagvpqjlnkN233cMftBuNiqcrXK7b047YbguDmf2g5Q7lz5uRYmVaOO4Jrxtx2UvHUDmjzMpPQ7Y/KQ8/1xPGDiPH27pwS9l6o10qoVPPHI2D/j2b6PzLjQKz6Dip2rd3MA1U04xbXCGRvZHWFK8uvmgBekKJhMvRKxZSrBPBxEfQNtvBHzWrGK4jWnfg6ZTwyxE0O9At6B4qwSu4Mxw0Csqkjn4c9jyInQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK7cpODuC2vrnu2LI2gP1Gpl8QQ3tT8dvcO1Znjx7OA=;
 b=Myi75pSZdEI6GCloybekft5B30zaRF4q9/k6UxQFd0FE1f1CddzIOoZw9zumAtp/nESCGH0uh58cjCIBb2bMoZbAJRdsIJ7+1P/bFE9a/T70jUvJu1SuaLwzacpM+KRXIAFlY+/z2HX6VGXw2DJoMlJPA3ZxaALFeis6MnNquRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:09 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 19:30:09 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/6] kernfs: create vm_operations_struct without page_mkwrite()
Date: Wed,  5 Jun 2024 13:29:29 -0600
Message-Id: <20240605192934.742369-2-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605192934.742369-1-martin.oliveira@eideticom.com>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|PH8PR19MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca59512-5b62-4a57-26c7-08dc8595e763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ha0zM0tyf8U9v7jHomCRL26QnfIJ7g5gUYuMR6UM4jakXEt79zvc85jMR7o4?=
 =?us-ascii?Q?lIcrwK9TYLHfye1abncNdpIGayYz/U9ovJB8KZuyAtoaP7RD8gtITddgr2av?=
 =?us-ascii?Q?Lwh63zq2CFfU6CZ7FzkDDyPKLdGJJ0T36G2kEtYmm0NniSJjtyyBmY1pgzCS?=
 =?us-ascii?Q?y1hnSHPWNHrB4reTdkUIpM7QCrRmYAfZIk9QTs5SOHeoiNOa15cXtt8Um4GU?=
 =?us-ascii?Q?L4rdxLbDiZACV+EGlUAqTB2wkoA/nDm52WkNRmaGIBt5u3nU/vNot7Iunuej?=
 =?us-ascii?Q?m/35T+nAvNLpBwNO9eX5p9Wp7DxOaoCPpolTF7QUKJCxnzgCkIrHX6mHiHzZ?=
 =?us-ascii?Q?O5Cuad0iXbvqTaGKcIqayl2hljLYBxdkfCiiUjf/Lr1LDRnA6qx36OzF5vd/?=
 =?us-ascii?Q?zPpvLjZNExrS77ySS0lpQ/xFC7Q0PHXQtsXmY0T2IA531iZe02W54sUm/DZs?=
 =?us-ascii?Q?KLu2nBpKg+QV+r8RUrb+INRKByPYAOWH1wdck+udcz164qCJaqoDGqA/+ipO?=
 =?us-ascii?Q?542etRn2zTos1VpBGDgJc5lQhkuXZ3gHMELM7xPHw9kFdtDsC9g62hzeDKcd?=
 =?us-ascii?Q?wmP3uh/SY6JMHuNH2OBZvoSgigvVbeCYEpI5Hb9JzDIdrW4HpN7M6/YzRmkd?=
 =?us-ascii?Q?2xHVb8IzAKwrAz7amZjiHB3zwA9ylXKmkNld+fCo62EsVZ+BjephcMMdgIGI?=
 =?us-ascii?Q?+P2g6PDoKQSQBToWbjZDbAg3pWPdVwyKSToUZR4XqsTcUhFamZRkrsfXqUtX?=
 =?us-ascii?Q?K4pyHuPd8HOw21czmunoXXi+S3dxba/Spv4R3hu2BWQkXHuNG5T/lYy+sCK9?=
 =?us-ascii?Q?Q+56gO+uIMih6ePgcZBqf1VArH7bu+riFgLJuB3k50yn3O5tDgBsliGMTXb5?=
 =?us-ascii?Q?5bTuutso6nulex4SDB/rgxp58/05bcjnPCZm8gh1evWl0P73zv0MZVUEuCfW?=
 =?us-ascii?Q?TzEGZu2o0zz6tTF9jP3hQD9uekMYtVQz3ZS24bzhnoEy1TgTKHD0lWhDYt0s?=
 =?us-ascii?Q?PTmZUzcuDyHp/Gz+ov3jqE7xJIhY4f4zf7bZK1BZitgCR8SxYPazuQIX/GuV?=
 =?us-ascii?Q?8rHRgsrWoeFVve6badBmrFWXGhW4J2ZgrEB7T+THslRp/oO4VUFeixipahYm?=
 =?us-ascii?Q?4Mg+WmtMBMwQoa03SGJxGCFv7tS9QZS+iCe2bw54LuHfZs2m40+kJj0hO+Ps?=
 =?us-ascii?Q?QMlti7LWV37uBshKSfCi0G5w0zWQDQ56hUcRPS78VQBq5d3rncpW0aVPy7de?=
 =?us-ascii?Q?htiu9W/m2IdiustqW4lLKtld7n7jjTXYQUJ0s98bxKBEAfD0qNjqRF/55xDi?=
 =?us-ascii?Q?7UXC4/Rhx2LFKQqKJb4Agq5KZ4WNHv4qTVQ/1adWq0Pb6DTtFqxmGUdqlZ/t?=
 =?us-ascii?Q?5GEEQbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Juq/p+vTeOs3yHRCDho5hh0Lca9J4NuKg2jMzC8esDg6cXcJg6CALNlrrHIJ?=
 =?us-ascii?Q?2aXxX7IUv6NLdSz1h9uAVmcZm/xYHqZaiPpRrGNi60JHUMDnyuJKobduKIQY?=
 =?us-ascii?Q?MSM6JNpXF9A78+kWMsfzgaYjBcaJuTEEPQ8FTinK7QAm05K7B1jcZip4Wa0E?=
 =?us-ascii?Q?9UBKbpSuoipUm4iVTqCTNDsu5ub3JEPFoZN/1EO1xY1h1AobHRczAUDBu3ek?=
 =?us-ascii?Q?NMh9IfXX610vNrcAA450xgNmxjLyc0MWiFldjC2mzsPTtDhqvJXB9lDYivEy?=
 =?us-ascii?Q?rKLDBieTHbfqJBTo+P8QEJBzdq9vkRfHJHRPPiPu+l+eoZVWOc+t42a76xgj?=
 =?us-ascii?Q?HJavN7/CctbOZsK+mYWjPDFZi/LkeUSf64I1cUyEzqzBJHnV8svntYdlI4Ze?=
 =?us-ascii?Q?D5z57u/nOQ0MAjiibE2/GTI8XegQjzBF51iviQSblgQkCFbnPr3mpEI44qfr?=
 =?us-ascii?Q?lRmSyMKSjigr47XgwY1+7ToddxzSUxKfYHzbtwKWMQ4OjkmOP5wVcGunYaou?=
 =?us-ascii?Q?isgh5xpv+mZtHVlnNCiPALgBqBqUuEgljQNzyXEtKZtv+G2jfKqzqlI7c9wG?=
 =?us-ascii?Q?4t8o8BdDWbPg84sxqJcjdaneyJCTFbtYEmbwJIL6iaaiDDYzCG1qibsgO/Pq?=
 =?us-ascii?Q?uTHhxrfxzY8wIJvqdyEJURsH9aP5VBm4xtCoGRP1B5a5mlUvMdm5vepxKaVU?=
 =?us-ascii?Q?1DpPqFj/BD7rPO3BSIbSOSVA+qONm0PnPoIAneYLN5/BOCmmodbQDBW1TqlL?=
 =?us-ascii?Q?f1WVVNzwBC/RAzwLJr0dSTMjCuRPJWqMszV4GEbJkjSdMOVhzkxdRgaDjffT?=
 =?us-ascii?Q?PbRm6u0tIn4HHxoSH0mrbEFIrFnCtw8PbmBPLs7RN2SMWkrYMINAnP/ZqUXk?=
 =?us-ascii?Q?W6AM5fPbfQePSBWYuB66j7T0R4Nt1zfFwdIf8aJB3pfjBBFL/I/yqTWwBIwG?=
 =?us-ascii?Q?G71dLrDlaMD/O8T3OZHWdU1r8f5xGNc8kAMzWIDzlEjjRo3TAi89mV59AHIJ?=
 =?us-ascii?Q?zCnXnpeMPGp9cK71VZwMSKkN4CD4TWsg9plsaxPmg03kYNlmQINcyEZsCJeq?=
 =?us-ascii?Q?w2KzP5CkmvIzgeK2VDLbgXhod0kPvlQFTex2kR/1G8DkID+azSDY78yehIY2?=
 =?us-ascii?Q?95hFRlZNOx+madKXVDzw/mn+6ZRu87x0ZdDHRB72OtbPp7C1R8O/8szZh7XQ?=
 =?us-ascii?Q?DCPnF4SjUXWy9MqU9NTWDkonJ8nDn6DzNFTLHmYo4UFm6VqsgsFVzAGSABg6?=
 =?us-ascii?Q?IFGlm1WxDA2sNENpJVBlnPsvLkoAM9Q9Jv2bAI3GTydwBlsfo7xBD7ewZ5rc?=
 =?us-ascii?Q?vg7ShCjSnOcQV1dLJnIcDYrg+/DJ4WrgUMQVnUtKhA2R65rT7Bo6IqY3IZ3B?=
 =?us-ascii?Q?Sho7792r+m39QWvFN5aME2qv+crboUaw1rYMO3PIDdnLChBiEuXP2hozVFos?=
 =?us-ascii?Q?O5lZPKdJg1HSzPG6qhojhZFWQOgpXQcJwY5qOXMX8/9iLxBfszpvEKMCvWwk?=
 =?us-ascii?Q?UohRWt0wOURn3+CKo3h7TGdrB4hjkSdO/hIfjL8B2mKYTaqdNifqzqHeEkJP?=
 =?us-ascii?Q?S4Xv85FWtr/LuUq17jfG7fzmzZDWh58ohpqM6L0Af3tBO90nZxllawYt8D3L?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca59512-5b62-4a57-26c7-08dc8595e763
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:05.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cpLdDav5zuCi0e5bleUHItKuVCW/1JJlEsyR2t1ScNPRZKi7T5A2eihQwdt4PHi8mH8Cvzlt8WiJT1aZ5EQe8NgD4AtY0/JuYB3WlWcPEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

The standard kernfs vm_ops installs a page_mkwrite() operator which
modifies the file update time on write.

This not always required (or makes sense), such as in the P2PDMA, which
uses the sysfs file as an allocator from userspace.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA over RDMA.

Fix this by adding a new boolean on kernfs_ops to differentiate between
the different behaviours.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c       | 15 ++++++++++++++-
 include/linux/kernfs.h |  7 +++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..d5e9fbded3dd 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -436,6 +436,12 @@ static const struct vm_operations_struct kernfs_vm_ops = {
 	.access		= kernfs_vma_access,
 };
 
+static const struct vm_operations_struct kernfs_vm_ops_mmap_allocates = {
+	.open		= kernfs_vma_open,
+	.fault		= kernfs_vma_fault,
+	.access		= kernfs_vma_access,
+};
+
 static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
@@ -482,13 +488,20 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_ops && vma->vm_ops->close)
 		goto out_put;
 
+	if (ops->mmap_allocates)
+		vma->vm_ops = &kernfs_vm_ops_mmap_allocates;
+	else
+		vma->vm_ops = &kernfs_vm_ops;
+
+	if (ops->mmap_allocates && vma->vm_ops->page_mkwrite)
+		goto out_put;
+
 	rc = 0;
 	if (!of->mmapped) {
 		of->mmapped = true;
 		of_on(of)->nr_mmapped++;
 		of->vm_ops = vma->vm_ops;
 	}
-	vma->vm_ops = &kernfs_vm_ops;
 out_put:
 	kernfs_put_active(of->kn);
 out_unlock:
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d..d6ae7d4b0011 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -311,6 +311,13 @@ struct kernfs_ops {
 	 * ->prealloc.  Provide ->read and ->write with ->prealloc.
 	 */
 	bool prealloc;
+	/*
+	 * Use the file as an allocator from userspace. This disables
+	 * page_mkwrite() to prevent the file time from being updated on write
+	 * which enables using GUP with FOLL_LONGTERM with memory that's been
+	 * mmaped.
+	 */
+	bool mmap_allocates;
 	ssize_t (*write)(struct kernfs_open_file *of, char *buf, size_t bytes,
 			 loff_t off);
 
-- 
2.34.1


