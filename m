Return-Path: <linux-rdma+bounces-3933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4BE93926D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320311C2173F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CE16EB4E;
	Mon, 22 Jul 2024 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGMBHIZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70116419;
	Mon, 22 Jul 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665105; cv=fail; b=V2XufZNEkDjcbUlIxTaRGALZK1TPEpt6rUI2BISGTMroNOWMTHaA/X/vnRo1LipjWVlJ1lUgKmymd3yGgiZ3rx+pTm9+nXRG0EpN5VIHbUgBDnyB4AdCXnQsevosl6DkESXF/Dc01V7H7W/cB3oxNFQZVldiIsYPY8zUSiNldGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665105; c=relaxed/simple;
	bh=C/L2DWwa3unvO4XRdkn/kritZwppyT8N6JD4+kbOmPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=btvv0Z9x56TUl7riCazfC3M///Wau5XKwL507kWsekzW6UrlL+mn9xpyvMwbot4pZ1y7WH9ApiH2gkBbM4pmIwkJFEGvnNXkRhSIIy2pa+lyuzqug/W+0RjOQUIYqaHaI7/3gwlon+Vcl0YysQwHkgPGyO8RAHMlvIhHQbJei7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGMBHIZM; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcALo/Wts84ypIr9f5s6HFHiLAMZyIMUYYjVHDndGQ5AnPGBErOagrP6r9aZEV6l4jViKmE8+LT5pNL8XhwH9K9lkgy1W3stWJPw/qsC0FcrIrgMwNRZA5fctoVM7Fy6h2C8q1xVSxOXAvaIxMzoSipliUNRM8VPiFoobK9NG0AEm4MuktqrUxtaJ6RAPk0fya0QoTIiOqOwtUsfXDdvF1i0V1z4iam3hUXot5XdQxafw/ihSfz6VtGLn16W3O5FFMsZawM4Rhtorhge2xkGYKO+wNEd8tUC27oDrDmr5g3cN1v1dH9OgOq4QNUFW8Ad2HmR6s0Hik/LXLLraAxvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPUgI70J41umDXgezAo5Tnr9VHKJPRQVUVqzWeB8vGc=;
 b=IQ1TpzpP2+Dr1unMzcSMo8izoNfrhrtqHZvI+CsnKw8iF9wL1C0GUdlHDMfopjO+ThC/2ZhfZY8EUstr79oHl6/QgNRsZLByi65Htscuooct2ZKtYJ9HwrQt3X1xbE8KAiSCXLeEW/yCKhWL08s4A2GXDwLtmkHOIivU9AIV2x4S+ofdc4E5H5qGeKlSR7JzvvPSDqNl+Bhkq8JChryzBoaSeHwdOgOrn6UpAtWQXxGOaLmnzoL718+CJQ9s/x5uZQyuBH5LMfXf10uIwbUAhlT6QtOW4/+M4jM411w9h/ylaNFdLtcmyCnFptTC2DkwUg7GIwRM8rSsnHcDJ4aDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPUgI70J41umDXgezAo5Tnr9VHKJPRQVUVqzWeB8vGc=;
 b=mGMBHIZMZd78wWqXiMrFRGuaD7i0IOiJf/pwQ5J7N5S5/gDfd3K+Y9EoX7IxojmKfyRBaNI1zaoPIBir0EuabcYH5vxyaAKqtHeOiV/qnVivdcIOaxfGEoJk73M1+zOar8v6lp7P9Yy0OhbLOkxImg12Sh/+Qi2/mpsk9ZM9xJrhILqW87GmYRL+AYuM09tFhyTzHZsvKHJP7RGX0EkcOQ+RJh5q+c+9k+Gofvk0BMDpxiEz8sVUq/KkyC4Kg/pew9HYjvgOeraaR5MBVea6Tc7odSrguJ7FuultC/RVWzdSgfSkFzvq9N1vjAWjP2rHa13dPWEc3OEZoeadW9od/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 16:18:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 16:18:21 +0000
Date: Mon, 22 Jul 2024 13:18:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
Message-ID: <20240722161818.GK3371438@nvidia.com>
References: <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <c1a2b518-f258-41f2-8b0c-173f32756f49@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a2b518-f258-41f2-8b0c-173f32756f49@infradead.org>
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfa2652-a7e8-43e9-853d-08dcaa69e73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t1TyfmS3v2XwOEKIRj5tjFemZmGpDgbw3A+YO5aXpmxhY0aYPCuhMM6PE1MN?=
 =?us-ascii?Q?ESN+Iewve41Zrip+bq/Y02U4+frE1v6yIsag2RZ3ohXMaeIaT0p2znmKZ+h0?=
 =?us-ascii?Q?peiyc7j7+z2jTg40WazSMtjarik2un9AMg6mQfXBe2d+c9jGuI59/pjxnLTH?=
 =?us-ascii?Q?vn0kZnonoksF6kgto4KA3wWHd0/ehZ/vkMxrO6dVi/tLpwdLqBBedsXXEwTR?=
 =?us-ascii?Q?cx+/Y1Z7UtA3k8sMFEa9aPNo931FVMgTDs0YhPjoTFGgFFe5eMUvjjJDn81c?=
 =?us-ascii?Q?Vjs/h2xqYVXm2Yrhoo3dV/+An9h0aWvA/zYfRXQeFBwvMPhh20lytqbNGDT/?=
 =?us-ascii?Q?mS6VtbBjWYeNUqgVtguJOP1Uz6MfvNGK6rwTisWDwzzEwCLdCpn1ryuuWZuK?=
 =?us-ascii?Q?1UtzpoNJCkJCnazKW35y/wJOcY92aav+3EzBg28vCwls/PFPaDDrD1HEEesd?=
 =?us-ascii?Q?/hBNJzEBetupf7H3NrBE2tIqPwqcGcvqS+KwsgPexqCLMytc+OeCzwaT/CSB?=
 =?us-ascii?Q?xaSMzehqNULmTYjo3mB0oeqis91Xev+QW/DHGfPLxVd2o2OWJhIwgQ84LFxA?=
 =?us-ascii?Q?ZQ9dFLQaqZzxfka17+K8QLBVFv5ST/GraU6+pemwyo47FPTPVfdrG2pJrQ34?=
 =?us-ascii?Q?dgFk5uMnJSYc8xNhkjpXPo/gw72bYTSVmMxS5bRnwISyc+RK3txZfYA2T/9n?=
 =?us-ascii?Q?px5FNBaZxEhX6lJbenFwvXNMh+LAJ+GcxMCy+ISvPdok7fqmOVRflvf/x3ne?=
 =?us-ascii?Q?twBmY+Q3G5+UDx5oLIrv8R1bcthRs5AGloWQ58Har7L/f0X8X5rs3CSgANJ7?=
 =?us-ascii?Q?pnqZMufa8SkdxoYIoyzqRoftgwX82SPEpQDG719hEm7+qRz9vADfvXpaDtcc?=
 =?us-ascii?Q?WIlqBYSQ2JX400kF7R0EJkuKEC6927lRfQoGD4rt2DGFuCBPP/mWL4rCSzR2?=
 =?us-ascii?Q?ZRGjgGEBL1SuthKspWQCy+b25f5MvdO5Et3NTJKP59q18zw0+4uNIJPfgdSu?=
 =?us-ascii?Q?QR5nEqB8q4iKDaVihIqdJ3NZPCJ0lLvz65MT2uKO7AOSgVnLqwcIyi6iigyI?=
 =?us-ascii?Q?f/jQCgfP7UozBBY+iDZZotdXyEOJb2hBIT0OFkqc11fpPRAmpbWG9BGF8woS?=
 =?us-ascii?Q?+RfkPicGdFuMkOPOmzOTyaepzMSMLSK7LiIPj4sbJ54V3TfnwBGfC/k+0X7S?=
 =?us-ascii?Q?3Vfj9YXu9Y+eIlFS9LNHunKv3EjKL0R8yRsEiq4VPpbQ/RqWCNVC6QQ1qGZa?=
 =?us-ascii?Q?0jds7b+VFeYMXpLnVO1K8xZtDbV1JSitE7RZ4vqzyBki5hunyIcc9g0kZ2DX?=
 =?us-ascii?Q?PqrpqHK5qtl/GttCJ9R4kxWUqtXiFLhBZnNu8npqk+pnlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeDPdm6vXD2TdRpVp2ezmPqUVtBrT9qVU8sDaDFEdTN8/qxo41eNdgnRlq5r?=
 =?us-ascii?Q?p3E3MFIMSJtYx/dAP3O328AnCTSSdFJm0J+/cw7Lip4fizAc/a4zav+RcPA5?=
 =?us-ascii?Q?zUOE07oym3ct/66Ic2qgqw8EXRBokvkLNxyJYdHvJz1FuMOICJAdjS7D/oW4?=
 =?us-ascii?Q?59BA2WCzOboxqqRYy8WKxC43RM9BUxFJhKgiaYt4DaI56GvChO5GgtzIRvKh?=
 =?us-ascii?Q?vgOu4FHlFsn8j+cR4OAjGNeJb8P8AK7I7jCPN8uDq49ObTv4c6bfkqtRXhUu?=
 =?us-ascii?Q?va1gSTq2MA7AKokvSp9RBdwzw7U1Uq7ZVkbcoJqy6TbzRp7wZ+yJ0H2fHvFA?=
 =?us-ascii?Q?0pSmHA4+1quYtcjrEeEd5VQcMh57vjS5TnGNKbIvWMCL5gN4NtoR0VTzNW54?=
 =?us-ascii?Q?XPf0Kmt+QVbiwHB5ZznbA0uvV0i5NBRJSpIQjvY6CKs1Zab4l9jKoMNZa7Qn?=
 =?us-ascii?Q?Vvg08yiFk9mM3QzvcttfL0TbLuyNH5INvcYoW+VV5me9iFyCNHWcjrOk8rNC?=
 =?us-ascii?Q?jwVQiaZ4EbrEziXOAD7bBRUZseEZtQJckRWfZ+ExgtfTj1d12obVAn1saGox?=
 =?us-ascii?Q?bbZhDPhgIjrP8ISuFgmO9/rv1YjO7Yu+YmztTjR/AkQzxpHM3d65cDuEIJA9?=
 =?us-ascii?Q?zbG7befpWMJrWRXFZBnnW5koEdgmEtKRPwlYYQZyiTThBSgmDIvU0BdPLP1t?=
 =?us-ascii?Q?ahfB13l2dJ63BRzHH4QXXujoyfLT9anApFKX6gsrCLA5U1uQmsb+H7kCcC6l?=
 =?us-ascii?Q?KM2XdK8Vr0wypCuq5qDdQJq0I+39J7c4eWMtZAU6MKXcQYZetqrb+RLnz1q8?=
 =?us-ascii?Q?C1wupik6X03XMOEVm/2CTkrLU4f4d4wIhvEC93vZXMKwuPhIPSy55sUNenwb?=
 =?us-ascii?Q?vczN02ykn+Kvq37mZbZF3Z1j/vjFVX5jFxow4Im9ccB6bjlcAR8M/p502p4u?=
 =?us-ascii?Q?/AmJsNUDDSCBSD6Ng5UvZTPd4BwYpOUF8AhLO/X0QTjssPvo5k0nxwX8ora6?=
 =?us-ascii?Q?hIk/W9ju4s0+QYunJGawSRX8x66c5M46RVrQeSPNdW2UxKge62loOfBOL/Ta?=
 =?us-ascii?Q?ieep+6Ok4e33dLI+EOQSs7V3wmuS0wrrv77tPDAS6mwI4d75k4ifct9WVuuB?=
 =?us-ascii?Q?zISj/lsL48S8TQQ7DUtpkBxIuSsLcIkOAaTbzWwKYuNzcgyZvyROfVdSnhnq?=
 =?us-ascii?Q?U2iagj4WyXvVFENqMqVPEZ61Nqq0kvzB0+r7sZ7pg8i1bzExB7sS9SI/hZFq?=
 =?us-ascii?Q?HkSxRnC+vusKwy+03UiwyefSe9TOp1koyq2nl9Q5/tdnIYZ7yrDHT80Q4uOG?=
 =?us-ascii?Q?3Gtze3q/sgRi6ImcCa31fDd1omanqGGlbSi5ejttddk+tU8SbyD5MIamT005?=
 =?us-ascii?Q?JRmv1lxu0jtlMFC2cEyJnoPXT2qx9nqnTGPZdYYJHJwBfy8sxoekZWUXiUxH?=
 =?us-ascii?Q?QK/pwefwHnJ2BkmEtHvAyvYVBt6MmTumqC3weX2kyOSoKNPKuZiC172Fcvkc?=
 =?us-ascii?Q?HYF6O0Y6JZT/+AI3D2nzUcddPAqOQP3m3Csr5OuTH+RIyw8pFpWGnCC5UqFZ?=
 =?us-ascii?Q?g8JkwrUOIRq0nlXvT8I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfa2652-a7e8-43e9-853d-08dcaa69e73e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 16:18:20.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kehnYsK44OA5jc/Rs9YKRnFlaZxqLtkWLfa7rVyILEvjWQbnnKXittrlKJhq31Xa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984

On Tue, Jun 25, 2024 at 03:04:42PM -0700, Randy Dunlap wrote:
> > +There are many things this interface must not allow user space to do (without a
> > +Taint or CAP), broadly derived from the principles of kernel lockdown. Some
> > +examples:
> > +
> > + 1. DMA to/from arbitrary memory, hang the system, run code in the device, or
> 
> An RPC message is going to run code in the device. Should this say something instead
> like:
> 
> download [or load] code to be executed in the device,

Yeah, it is a hard concept. It is kind of murky as even today's
devlink flash will let you load untrusted code into the device under
lockdown AFAICR.

How about:

 1. DMA to/from arbitrary memory, hang the system, compromise FW integrity with
    untrusted code, or otherwise compromise device or system security and
    integrity.

Which is a little broader I suppose.

> > +The kernel remains the gatekeeper for this interface. If violations of the
> > +scopes, security or isolation principles are found, we have options to let
> > +devices fix them with a FW update, push a kernel patch to parse and block RPC
> 
> fwctl does not do FW updates, is that correct?

I think it is up to the specific RPCs the device supports. Given there
is currently no way to marshal a large amount of data it is not a good
interface for FW update.

I'd encourage people to use devlink flash more broadly, but I also
wouldn't go out of the way to block FW update RPCs that might exist
from here.

I certainly wouldn't want people to make their own FW update ioctls
(as still seems to be happening) out of fear they shouldn't use
fwctl :\

Looking particularly at mlx5, we've had devlink flash for a long time
now, but it hasn't suceeded to displace the mlx5 specific tools, for
whatever reason.

I grabbed all the changes here thanks!

Jason

