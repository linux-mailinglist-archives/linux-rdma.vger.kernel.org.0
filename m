Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12C4A5EDD
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiBAPC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 10:02:57 -0500
Received: from mail-bn1nam07on2050.outbound.protection.outlook.com ([40.107.212.50]:8608
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239679AbiBAPC4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 10:02:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJx5FZ2TyE5d3oXqyRaeCWhHKyS+JU/ADFpYLoUTnf50ZLZP8X7YIQdiQfzp8DlDukfF+TEURlvoYZzooVIzRRIf4N5zCn5ACsvak57FI82ss9dHEov8XSjiIm9rgoag2eWGREyPoD+4CqbKysIlyZ2rjJPdFZ6tTRUY/EKbBNKm6/DeB364gtDW/1+FCbHEDgS5FzqbRGJIgYSeuXjG5oIb8ysb20sxj4mtOIngS3QayuBqMQ2C+5HTOu35m+UPP//9Oy2b5s/6YJqLrFDXvWkSgkqkJfGi0Tzqpsq9P9QTfddrzB9F1ECcjKbfFbFd1QCqD9mhnzZLzRS+0DeOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwg4VMIN76rbTXHRgYGSTnmO1hOR/dBzbKAM9LGv5YQ=;
 b=OmQyt/9+ocYN53jfl+sRxcLH9oUq8i0VZTsAsqanGJTqM4ibxRCgv9GC3KiPRxVpQwARQ43gTqcjB/tCtaG4pLem8Viuy7Q4l0t35zuTav36v3xbhwbPRKh3kEw0LTt5Ntn1fpb8F9+CDAjqwANAX0AcXBNxHEgJpK1TdPn2rp7V38iwQMRdkwqhb0UN/JWORorbvWjJnITeihogbjDqSR1HpQmwzf70SNlfEC/m0JuaeezTF1NO7/taYTXh0xH+K9nh3VkZhvbGyncInV0G05H8v+D6chPys+XTMWZT902oM+BnsZSnrRB/PzsWubxi5LOADs+i9w2KiNuKgzpeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwg4VMIN76rbTXHRgYGSTnmO1hOR/dBzbKAM9LGv5YQ=;
 b=btmoEnzM4Xyf1cpNzqjZUQ/7GLH+L7q3yDdZfrc0I+r6tN1zvXxdtWADUQ1VgGL2W+NINhCnE28cBEbk4thxMxik/kEzX3EJChLKsOXn18cOjgb8EksSSwotsKyAFoI987A75a6eww40rUvUEuGFnMYn5hBNeoIIJGXwh4xHX9zikVY6PhEF18Ffpy5GGR+g5GxY81nVNrDTQ7GTwzU3A9RQc5zZQpeSnMHavLso+1bvXXN0YzetZeMozX1Cporn+K1Wt/MigrMsaKhX7ly2KY+rSxBe5WPo3C9jKBSpaTEURsSGUM4b39elJrMzhSQH0jXGJTqTYT/vGXYk3sPj9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 15:02:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:02:54 +0000
Date:   Tue, 1 Feb 2022 11:02:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: remove redundant assignment to variable nreq
Message-ID: <20220201150252.GA2434511@nvidia.com>
References: <20220130225747.8114-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130225747.8114-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc4bd74b-60f2-4e84-fe7b-08d9e593ec62
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25123402B3E84C71D41A0F28C2269@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: it6kWVUYgRUgxYsVUuAGgv6J1Il1sQX46QHrG9N6y9hpUS17ghnEAQfwcihWjD+5c6QZCviMsPLWGzwvxi/59WzLjNSR5lLrBy6GbCD/H8+CvYa6glDLUPQF1VRY8ZPeA/gfTIjY4fDG8/7xMv33uMyJ6Vo2cIBVDrxQCO/2mFJ+BvBs3s7WIBnN4E9OvprswlMn9YjEB8qzNmNLqGCMXLyRcCTCSiA6ifeUaEnXu4StSsjECSNmUZBMIGTYGXDfSKct0mzDgiK62fGSSY7mCCm10Xrb2Lj1wE6NQGT1TCGEaoo/k57jJrTF0i5j0d4/Yeu5rlqQoPkD9JDpePUbisXHm8m4Jw/fXe726wc/ekYVLTU4eaW1/28ciGBR7GvVXIRgGAcDSn0sfctPl3ddQDaYOzv56oesepRZ33LbwDA8oN2PQPSNzT9MkokdxEsRkJVHWMt5U3G9QIyA13UAJ2XHY70ShLsrrkclJ96ZlhGfbpfh3ouhE1re+th74ayCEd33hn6qDQofdtVIwOFu9dSeHNOhOQLsSIxZyjZ2GmFBWsii8z56EpiitKmFoRwDX3S+C3zpYhn0styAmJXjixdYzjWOS7etCGpmRJKNW2gxZITLOrUbxU+bUHaYCVTT3fTxMpWnIGkPaAfm9r9OJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(1076003)(6506007)(6512007)(26005)(186003)(5660300002)(2616005)(316002)(33656002)(6486002)(508600001)(4744005)(36756003)(4326008)(86362001)(66556008)(8676002)(2906002)(8936002)(38100700002)(66476007)(83380400001)(66946007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbFOPfZUCeHNOVU6p/SNssbq898zJQRMLx8x6k5/GovHb9EIN/C/nG95Bkvn?=
 =?us-ascii?Q?wRz0R5amTbNwxGYQ92X/Q5Nj3GvmpuLuk6+kzJfnasUDqXjWDtoHZBECea7K?=
 =?us-ascii?Q?/mAQG1zqhCxh9NlvKCyQDNqQjlT2pmYXCY1AqB2oyspXIexmOZa8tOi6UAt6?=
 =?us-ascii?Q?53Z4NtrghQK/YJrM1AoM+9yku6BKmHu5LaDeCvblrUnmqxjpMJdR9hELvYK9?=
 =?us-ascii?Q?WnC7JNMn+KsfznnGEOqSD8Rl//UxmKQVdD7e02BFgFC+5+i/Hq4dVSDiR79W?=
 =?us-ascii?Q?B1i0an5Nwd8W7b4w/W+ICRhIXkViT2sQJHqcD/ixRiofmeNP5nesbsZJUbfU?=
 =?us-ascii?Q?4ZBhEoeBS1b1UlJXpSDaFyuyD7xC8eiUskLkX6Na6jGZCKLeUt+Yp1Txj5f1?=
 =?us-ascii?Q?UyQ15gZiGUa5FKDQs+WCG991L+wx/f3SGH5+/UY8MX4S7PcY3tRIHZKxulfs?=
 =?us-ascii?Q?DD+AkvgGuZmVIAsy3Ln/qv6v3goRRhN8j+zyuPpWqXJQwGQ+U75vCiBzNSPm?=
 =?us-ascii?Q?8Ell6CCBjAsd/AXBgo00J8bex9pSB5yba38S5v2T4cN6ZYcDgvYpvPCEhtsG?=
 =?us-ascii?Q?PzbwFlTh3jbOQCeoPQfOmlNQxKnD06r2sRiFaUEvOyAEa3TYeuTfjK/N2lkC?=
 =?us-ascii?Q?LSnuInsJqtI1BPXio3ILI2zGqVfcqEFciduEASKzbYc08+feUAMrdwn//zbI?=
 =?us-ascii?Q?XTmtrJnBixLQUBJ9hlxf+Y7S+833geqJ+MaW2/WU+WgZ/MD+ztYfqoR+2oJe?=
 =?us-ascii?Q?97R86tHh86Vo33P6CK7AGI4ayk7pcPS1txVNnpLgCZaDQRElXrIQrC4r3bk6?=
 =?us-ascii?Q?ZeHkmYVaFFoCN4+KGjAzImWMqRUsz5hEgpOPNtnKrDnmpQ6qKA9TCHlJJkvf?=
 =?us-ascii?Q?JChpRdmUQ7zetMwhFiac98xSCvfFy0ZziqJMdzdT5Mmjm4JrNzv80y1wvNg3?=
 =?us-ascii?Q?r7kuc5s7VojacYPoNL3RmkLT4y93CtB2uTZ4V4To+ToXKbCUEs5NIq8wG8th?=
 =?us-ascii?Q?QWpY8RoJv+nkMCNOQ5fTr+eZ3Xtjm9J+ixL3k81azre18cVyGHMvbRFTQZa9?=
 =?us-ascii?Q?eaEv5NPZUhaFSWPdGpTrrNyIouNJRCdgacQ9PTWGs8tU2mPsFMC7XPSo3ZCX?=
 =?us-ascii?Q?kJwZMrQSsuywQbczyf3q6Yc+dJK9NZI1hgninQ9B+hz7Oxiw4Gh6ndOc5Rkx?=
 =?us-ascii?Q?ShqJG7hDj/wol+w/hLgs1xZrFsc/W5chBWnk6TLYK0BbTNmvyuVz/1hs1i9K?=
 =?us-ascii?Q?ZDvQTfj/jarZYAvGjpfqyAM+CHLexTt3xhdTxIyHBgBk3CFA9JqaPVclHlhp?=
 =?us-ascii?Q?XrI5iX1eDcbD28WjDcCWHqL6tjXW1YmXXRxzye2sQAMWUlmxqT9U3KM/787v?=
 =?us-ascii?Q?/rbRTe5yMORfg6gwSeGGxgnWSCoEWEdvYCc9UpSt1AHovAcYmgrrNsHZEzQy?=
 =?us-ascii?Q?6Q6EDuIEnpqNhllak2NnvIIMhGEbfLgyCR68AJMCnSVtzPxfoFu2g92YQxoZ?=
 =?us-ascii?Q?9QbQ7kn1Uz5w9cxUec2kkPsRNCsxD6Dat0eyiLpe7bd5knqteppJ9rtIFdiZ?=
 =?us-ascii?Q?joZ61VlojUxf7IlFO94=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4bd74b-60f2-4e84-fe7b-08d9e593ec62
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 15:02:54.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRYSQtLhzKv4ilqJ0wr5jcWqqih7tFyTk57nlsSeaD7YdVODWhNqUvuEv/6sNpo9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 30, 2022 at 10:57:47PM +0000, Colin Ian King wrote:
> Variable nreq is being assigned a value that is never read. The
> assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/infiniband/hw/mlx4/srq.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
