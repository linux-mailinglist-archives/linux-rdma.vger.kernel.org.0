Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DC39BABF
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 16:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFDOOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 10:14:51 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:46451
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbhFDOOv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 10:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgF/8mnMmReTNvlwUd+XGeujGW3Yx+zVTMRT9e3s7b4gkck2lB4CgFi5KIDiGKD3ly34OftjQroelm3gdgTUP0GGBW1Xn+Hbhhg4gpVBcaXb/01jd59SS9Y87KUvM1FJbT2nL4MfvTGHjSslBLL062CA7kjsqgn9lfuLmUFgLrF0aWUKDkyoI0HyoxuuG9GFC+V4FQfw3cqtFGmIimkew1cjDKi3m2RN0iPNQBNcfd0IeRDoRLWNxCFf/x3AfuI2qTYM38vbv+WVfSHjhfJxLb9oJNaGQOJdp22YGfjw5rtBlrSO9kDogjmehBvoZCSO/+vtyLBFsrb0bhdwIloBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaokXneJD8lGI230/EwOT+yBytldFOkXFuSUObLhqes=;
 b=FTh41tcCej9S7sYx+39ixDIy84QPZUu5RgXn6rvb0V1V10SjltyyCSkR2R00ewgVZV4JryG5q3K+YUoyyXV7E5fNEBGXQe4d67vYyr5nKK98z4mui6OY9DwWAwXG3gLlPBNHPdBDLLcCCGjCRGebi0URL/UldSw6CmtwjM+lXLYc1H35q6dRQ4dy4CMCglX7N2fgMOoZOGREJAKRYnyNeyHuxXabsRxfMwoW2DccNwwbJVFv1LAE0phu6CY4qSwOY65Q60zWuTErbvBiOrFkRZUBgT2nBftL1Nb05XabncnxdeAL12EUEAIb95blk4gf+Chdym3MXX2HsBR3gs5ukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaokXneJD8lGI230/EwOT+yBytldFOkXFuSUObLhqes=;
 b=Pg+KWamDkee+KD5TFyxQroWCk2yFMdz3uB31T1+Dnecks0bQFC5x6tRNp+j09+WmGs3weVdqsNYMqEbQW4zvpMxrPKx2IcCGxgsveCBKXDw2mOZur+yTZn/+jxcy0doNROuYC9vrAIOyIhLzQI1id9TaKNIO/AdaMP8iMPvQPYAuDmOi7qNdzFSAUtNnG7ypIeVp+Td67uegcjRpq1MK7qfyCRAjSm4FRLeIhhhw45xvJ62cZ2Q/t5exbkaZlq6TmmHl09Lf28fYbVtsvpS/+21CFciscSStZRgJ8nRT7yArBO/yYt5UqQcracsxbSMMGvjDETP1DYbEhEOEtkd45g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:13:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:13:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
Subject: [PATCH rdma-core] docs: Add a contributing.md
Date:   Fri,  4 Jun 2021 11:13:02 -0300
Message-Id: <0-v1-b00db5591f60+96-contributing_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Fri, 4 Jun 2021 14:13:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpAZK-001gZi-G2; Fri, 04 Jun 2021 11:13:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1967b7ca-f995-4e00-f901-08d92762dde2
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55089A04B6940999F8E047CCC23B9@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KEo3oGV4A3aiIhn2Lq/E8T6wS3/cAaPY7FH063+D0JT8QT9ZhNJIApdUZXKwDO7Qg43sqf+/HDstQW4iJ0KiGpElkONNQvUHlKQcrDgrP7ADlJ1KT5/m0dqdBNGA0Zibx6BiW+EPHNvo/v0MrgP8/1zAhn3jgA2sd+mqXrowLop0Z69TYh0Yla9XExEZ7L6WsCN2nb4+oFqC0ysj9z385Qy3MR46ZWalnDpSWZzeUO4NM2FByElbOFFk8iWMrZNmiY1BIdxOZ6WQ0IB/S2lcEnRc0YXciwu/2QEaJh0Nn3XIXQP6N7kVCULW1EMcQ3EK2zk1IgBpBiEsRo3bKWvnEDAO/RTaeNVjVijB+7PlYUVBCyxc3lPRhNKyp4PSvILaa2IDeQSAPy4yvCBcxlz6oqlOlO+0leC2hBaiXCuPOXhZ8RksurQc4Sb6yCXXDA+5c4TfpQlDPtGGWpmNR8a3sSdE3acijimDQp8TvM3WX0va9K7RShW9n5x9dmY6gSDV7X3BpWtcy8dlWrf54zEPglYf0Nbk6Sd1KNwW3tOHMPxWaAYODmh1sb8Lpl1JGe1mdGGjL1CIZFrRPd05LlJiK5UI8gbHUb7XdzgeIQvqft9uG/cCSHu3pCQD1N7nM3F5DclfrcScGCKtC0OJWvE53+zgDiSOgFRnoFYAgvpv16MHNFP6l3iCxH4v7OHVgo+82erRAYisua969XCMQ2s7wtLpFAaEZDysCcFwawnMjBw22TfUVvt03RSOoDu2bYvHS7SS3FPLRFzRXg2+VyX65XjU3ZCldqunpT38B1aI5JTefCi7lGtU1Uh+dbrp5Ek
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(66946007)(6916009)(66476007)(5660300002)(66556008)(316002)(36756003)(86362001)(83380400001)(26005)(186003)(8676002)(2616005)(478600001)(426003)(8936002)(38100700002)(9746002)(9786002)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ys8akOYtBpf3ekEIKatQVE9e0ZAh+O2W2ngJNBP02AS3Lkp9wtu6eSehaNkA?=
 =?us-ascii?Q?NGS8EwuOLBu/nC2qy0Li1MW2FYbQJ4tQhC6Wfh/bUgEJ7TSo04V8KYoHhbro?=
 =?us-ascii?Q?JTcpC+EgXpTDoWVNu7GiwoMn/clMbFyI93MWx8ItB80bd3xjjRTI4PyA6F1p?=
 =?us-ascii?Q?F/P0qdV0GScRcO/vCazg02PPtix3v3jiYPkpqxyeOfFVgEouBBTVvVF0yqip?=
 =?us-ascii?Q?VkmF9fBcB8M7m01Z84c6Sc6Emc26cfldNnGJ+7MHxn85YqA3PSSMWefmwPSe?=
 =?us-ascii?Q?O2R5nqDR5c5YLiODKINdLsRfrQSfYklHkrZpYIhc8qkYXfcbemLylsOvmbKN?=
 =?us-ascii?Q?ELK7A7dn63JX3Uw/9M7UcQcz7uIfGupX406+stoSL7OmcCl6zv1TgfOwtwLs?=
 =?us-ascii?Q?gIuxoHPL9DF0VO1/od2Z75Kk+TVmySb4ZEuyZaczCtbhPBoKhdCSdhkCA8g2?=
 =?us-ascii?Q?9lPIZIxh8DFGrsQvuk/2tjibbwYLTIo6LoyptztWHiqgnFS8CJb2GsSqWwfK?=
 =?us-ascii?Q?9U2S9zWSRXHDoHzhwNIQVukmrF+cf2co/TNBefjX2TpiDdOgSLubXZEjvcAR?=
 =?us-ascii?Q?dJf3i8+EElxVsxrT8jHS0WXBIq7dLeWJegYZnbmQFHKhPFXcmUpZGoHdA0VQ?=
 =?us-ascii?Q?0Vo6W7PWI4WsK8+VV56dIHRWpx12cZQWkXcnDGXTy8NO/LoxpNwr2Y6tCfrv?=
 =?us-ascii?Q?CX9HjLNFFpknZeTQqxmFLv3NpcqlshiTINBE7BVR7bmP7a5/gqDKpZVSiC2X?=
 =?us-ascii?Q?9il2amNDAhiu+Bzx64W5BjcwoDo+mkcUagbtpBjMbQFaHzv6zkM6RrhVsemx?=
 =?us-ascii?Q?rM/EhW581gNKpFMLNdZezY31Y3mZqmNFIjLlMFJIzsjxd6noa8LXPwCJ9cOY?=
 =?us-ascii?Q?l0oYEJZuMq7EEx7VYBw3/di0bj8vXKSssQJeqSRHughafI2j54oZmO7mrYf6?=
 =?us-ascii?Q?OJZ7TMJjljkTdLB+thJEPCuimcaTwRupjO1D1WotySmS3/xUvt42/VzF/fAM?=
 =?us-ascii?Q?MPPt667SSU2dq8sBfpzsiMYekTpOmkchSs148e9cpMlLuc7/t5AgXioJHtMY?=
 =?us-ascii?Q?UusuYyZc4pABQYm3Mpt19gaFBN/6fpyNhrbYCc6oAm/rGmT7l57uLFZuFgdE?=
 =?us-ascii?Q?9Uxog1KaIchHZBsP48abwwuiu9FUwIVoGV2OKZHdEoQjZ6KPpbYxHDHNiTbb?=
 =?us-ascii?Q?Epflcbo3V72YDOSYAJMQHiPEm+Jr2+rhJOpfSRE41M8qQd7Prj0L993L0IfE?=
 =?us-ascii?Q?lpbzP6BLUeD2y9wEocPtXvjHszQU/BBgOW4kxKN2JU8iT3My0sMRp8emPwQw?=
 =?us-ascii?Q?6PiyEAh7mGLyTR9fZLGoghdN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1967b7ca-f995-4e00-f901-08d92762dde2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:13:03.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbBicUSemrKMszFXIWOIHseupJn8wJqjOweGFCCgsFTXgwIyAmY7cG1fvLiExOTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Discuss how to use GitHub properly and document the special kernel-headers
process.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/contributing.md | 164 ++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/contributing.md

diff --git a/Documentation/contributing.md b/Documentation/contributing.md
new file mode 100644
index 00000000000000..e2868da3958138
--- /dev/null
+++ b/Documentation/contributing.md
@@ -0,0 +1,164 @@
+# Contributing to rdma-core
+
+rdma-core is a userspace project for a Linux kernel interface and follows many
+of the same expectations as contributing to the Linux kernel:
+
+ - One change per patch
+
+   Carefully describe your change in the commit message and break up work into
+   appropriate reviewable commits.
+
+   Refer to [Linux Kernel Submitting Patches](https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst)
+   for general information.
+
+ - Developer Certificate of Origin 'Signed-off-by' lines
+
+   Include a Signed-off-by line to indicate your submission is suitable
+   licensed and you have the legal authority to make this submission
+   and accept the [DCO](#developers-certificate-of-origin-11)
+
+ - Broadly follow the [Linux Kernel coding style](https://github.com/torvalds/linux/blob/master/Documentation/process/coding-style.rst)
+
+As in the Linux Kernel, commits that are fixing bugs should be marked with a
+Fixes: line to help backporting.
+
+Test your change locally before submitting it, you can use 'buildlib/cbuild'
+to run the CI process locally and ensure your code meets the mechanical
+expectations before sending the PR.
+
+# Using GitHub
+
+Changes to rdma-core should be delivered via [GitHub Pull Request](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests)
+to the [rdma-core](https://github.com/linux-rdma/rdma-core) project.
+
+Each pull request should have a descriptive title and "cover letter" summary
+indicating what commits are present.
+
+A brief summary of the required steps:
+
+- Create a github account for yourself
+- [Clone](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository)
+  the [rdma-core](https://github.com/linux-rdma/rdma-core) project in GitHub
+- Setup a local clone of your repository using 'git clone'.
+- Ensure your local branch is updated to the tip of rdma-core
+- Make your change. Form the commits and ensure they are correct
+- Push to your local git repository to your GitHub on a dedicated branch.
+- Using the GitHub GUI make a Pull Request from the dedicated branch to
+  rdma-core
+
+## Making Revisions
+
+If changes are required they should be integrated into the commits and the
+pull request updated via force push to your branch. As a policy rdma-core
+wishes to have clean commit objects. As a courtesy to others describe the
+changes you made in a Pull Request comment and consider to include a
+before/after diff in that note.
+
+Do not close/open additional pull requests for the same topic.
+
+## Continuous Integration
+
+rdma-core performs a matrix of compile tests on each Pull Request. This is to
+ensure the project continues to be buildable on the wide range of supported
+distributions and compilers. These tests include some "static analysis" passes
+that are designed to weed out bugs.
+
+Serious errors will result in a red X in the PR and will need to be corrected.
+Less serious errors, including checkpatch related, will show up with a green
+check but it is necessary to check the details to see that everything is
+appropriate. checkpatch is an informative too, not all of its feedback is
+appropriate to fix.
+
+## Coordinating with Kernel Changes
+
+Some changes consume a new uAPI that needs to be added to the kernel. Adding a
+new rdma uAPI requires kernel and user changes that must be presented together
+for review.
+
+- Prepare the kernel patches and rdma-core patches together. Test everything
+
+- Send the rdma-core patches as a PR to GitHub and possibly the mailing list
+
+- Send the kernel pathces to linux-rdma@vger.kernel.org. Refer to the matching
+  GitHub PR in the cover letter by URL
+
+- The GitHub PR will be marked with a 'needs-kernel-patch' tag and will not
+  advance until the kernel component is merged.
+
+Keeping the kernel include/uapi header files in sync requires some special
+actions. The first commit in the series should synchronize the kernel headers
+copies in rdma-core with the proposed new kernel-headers that this change
+requires. This commit is created with the script:
+
+	$ kernel-headers/update ~/linux.git HEAD --not-final
+
+It will generate a new commit in the rdma-core.git that properly copies the
+kernel headers from a kernel git tree. The --not-final should be used until
+official, final, commits are available in the canonical [git
+tree](http://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git)
+
+This will allow the CI to run and the patches to be reviewed.
+
+Once the kernel commits are applied a final git rebase should be used to
+revise the kernel-headers commit:
+
+	$ kernel-headers/update ~/linux.git <commit ID> --amend
+
+The updated commits should be force pushed to GitHub.
+
+Newer kernels should always work with older rdma-core and newer rdma-core
+should alwaus work with older kernels. Changes forcing the simultaneous
+upgrade of the kernel and rdma-core are forbidden.
+
+# Participating in the Mailing List
+
+Patches of general interest should be sent to the mailing list
+linux-rdma@vger.kernel.org for detailed discussion. In particular patches that
+modify any of the ELF versioned symbols or external programming API should be
+sent to the mailing list.
+
+While all patches must have a GitHub Pull Request created, minor patches can
+skip the mailing list process.
+
+# Making a new library API
+
+All new library APIs that can be called externally from rdma-core require a
+man page describe the API and must be sent to the mailing list for review.
+This includes device specific "dv" APIs.
+
+Breaking the ABI of any exported symbol is forbidden.
+
+# Developer's Certificate of Origin 1.1
+
+By making a contribution to this project, I certify that:
+
+        (a) The contribution was created in whole or in part by me and I
+            have the right to submit it under the open source license
+            indicated in the file; or
+
+        (b) The contribution is based upon previous work that, to the best
+            of my knowledge, is covered under an appropriate open source
+            license and I have the right under that license to submit that
+            work with modifications, whether created in whole or in part
+            by me, under the same open source license (unless I am
+            permitted to submit under a different license), as indicated
+            in the file; or
+
+        (c) The contribution was provided directly to me by some other
+            person who certified (a), (b) or (c) and I have not modified
+            it.
+
+        (d) I understand and agree that this project and the contribution
+            are public and that a record of the contribution (including all
+            personal information I submit with it, including my sign-off) is
+            maintained indefinitely and may be redistributed consistent with
+            this project or the open source license(s) involved.
+
+then you just add a line saying:
+
+        Signed-off-by: Random J Developer <random@developer.example.org>
+
+using your real name (sorry, no pseudonyms or anonymous contributions.)
+This will be done for you automatically if you use ``git commit -s``.
+Reverts should also include "Signed-off-by". ``git revert -s`` does that
+for you.
-- 
2.31.1

