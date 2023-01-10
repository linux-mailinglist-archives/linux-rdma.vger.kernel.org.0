Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6E76643E7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjAJPBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Jan 2023 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAJPBG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Jan 2023 10:01:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604FF33D6D
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 07:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL3r9F+3KfSP5IRG5WT8ApIM0lJ/tVjTFbyTeG7uGC5txmEdOxR0TqsM8QVYe0aCcUkVLwhHvUNQTlTLm2ToUm8Xv04Zknp+3yaICTlYRoHYdPoT31CfVHSOzKiVr1BvfQlDvLhZbBCBpeuBu8jtJenhuoxg4vnPutVyqA/Iipo2zNgXxNBeZq2FOY/yh8oOUxT8nho2lbEMRxylwnpheJImfrV6r+q9ZXHjf7HT617KS4KnhRR8SLPKPS9knahUQ544ispqUcDH2VEvA4fa3JCaaoD/Fgfp+V/D5RuFcS+tdhygKmHWDe/5/pjg2Ve/9SjcAItuwGg9UR85nlweMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT4N8Lb1fViAkqMpAa9bP5GZ/lMBdButJVn9Ndysw0A=;
 b=N/PN67TcNCyY1Ch2VTjW6fnnVdrnlzsj/p3K+D9M0U1Da5C8mUvy+6oGQRyosGK/akIrTmuYWaCJTpsxyJ2+fqVp1o0ev1BMWYNhVHOvc0yysQ/jUUFZwp8MA7DlePY2EKhR7VqsSQJWDSc66h/rCDiChAT54vzx4+4z3AAy1sXPpiz3zPeRnMCRsaRhjHr4v/sSS0AYGv3ORgyaHp8BAza2E1F/MjJ4YZuuY/vN1UzsMzmuD4VtjCVZfLYgvGDApyYEaqaWSz6GcrOR59SU81RfvgFFxQ/sIeQRxLQMXnPm662wZM36RmSxIobESOJ1oosrbif2jhyjDTUnvIgilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT4N8Lb1fViAkqMpAa9bP5GZ/lMBdButJVn9Ndysw0A=;
 b=FZdfbbkqfbTbgGdm1BDr749gWYM5g8+I1Tw//ddcxP1T1rsJFL6CXDrSYsMnJvwI9+ivzJ+QWpLXdW1BzSeoegrlR3kF4NUdHcRFTvZ9puVVUpY0WGEqZT/wEEADt2i692EZZcf/7hPODVYeDLgwKqlAK6TlCVFN8B5WwdPpRU0Qq5O9z4meIrU2TmyaL/bE/zZifqwP6klyVV8A4ofWC64q7PNv2fZ2bHuQviDyhBGAOwVmi4GkcTzWLmbbijx8HvjE37wTlwgo8VoUTFyFcVim1ws4dVC4UGyDouutcFcoX621qW0Y/0TyAT4yHS0QgjtU7vposfQWOrXsPnwUcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:01:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:01:03 +0000
Date:   Tue, 10 Jan 2023 11:01:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/3] IB/hfi1: Fix math bugs in
 hfi1_can_pin_pages()
Message-ID: <Y719rou2XS3HdVjY@nvidia.com>
References: <167329118368.1478031.13301737756220998277.stgit@awfm-02.cornelisnetworks.com>
 <167329170075.1478031.14048412547851558553.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167329170075.1478031.14048412547851558553.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d914a6-e3a6-4b8a-f59b-08daf31b7dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ti7erAWZ7rtawOqUh+qnUQrYWQkRTvoY7ENs8qAGEMXP7pbl4oUSgYrfGiQNwfORIAvoL3eep7AVQJhsh/dEeZnqDHJrZ+ZJdfji1glsnz8zPgKkais27bk96Lvi2sOAt0d2qqzJ7rVX5oB6Gj/Ks2W6VMoV1++OH+RjkHA1PyX3ULOsOACdJiJ9RmNLOxP9bpl0LNYwn7Ebq4TlsOz1CEWbOeYGpxFdYUEE/rqtABOy771jd5J/+1VHT7tXe2uCbNHTzLJ4zSf96wC6RCZFnHBH0TR1e6W7wleHpCo+FwCurHO8LHOCNeU2vfBJQLa291v2hfvziFgvo14v+IRr8TudzELsrlUhQ7s9eu3MiRa2rSwyio57tPNGTqSN2oRwQSWVL4SiBtXS4/BVf6KYh25MazA9+N/8aosep9qDzKBxgCrr8LlWdYwoJjfa1oUwawNk7OvnHUF0YkZe+zU/6PpLth08O1nPZo+NcmG4J+uyKT898FtpeUsYHU9SXJJ9ytC3oDOQy4tX4c3BYUNiteU9/vphTM4vHwC6LQ6mgFxKFfPQJkEl/lXCymx0Nc9dhy8oaqQdA6ZwKnymRv6qxGVIhmt66sUoLlYZ3xjM1rkqs9Kd9DcfZyovfJaxi9aOZZ4mfDbdv1Tn0zr2XhOZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(38100700002)(2906002)(558084003)(36756003)(2616005)(6916009)(316002)(54906003)(8676002)(86362001)(5660300002)(8936002)(66946007)(66556008)(41300700001)(4326008)(66476007)(186003)(478600001)(6506007)(26005)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPFE2Gv4AeQ8TtHNQ4dwfsvy8Hq53jAIyHn2+desdlYyTIgaFFLqLeERdCbA?=
 =?us-ascii?Q?cznYl0TiJOdRob6W6+GURYOwLQilUDOyRkFk1TYJ1P28Pdf8cfXiZlQvmRhY?=
 =?us-ascii?Q?E2sTIwJkEocdh4MBJUqYKoIHIeC+17X9kSxuTSd64j53+D4FIWL3zO9iEAbe?=
 =?us-ascii?Q?fUYnBesYaR1Sgo4Y2iamNZjB6GdkN6biydtgXYzu2cWnMwBRBrn5GXLTKDj1?=
 =?us-ascii?Q?PY2DzbenGdZ7x5iua6OBxr0FlrTAGpe6RFh02/jmn0E0JdS0DiAH5cWK9gRy?=
 =?us-ascii?Q?Q3DxcH3Tvr+vqQ9v94AYgx6t7EQZgO71pN4tYxg/aMRqJVf1yLTLYwWHwpgs?=
 =?us-ascii?Q?E1uFvi//zB7OdIEgGqYRCRgpQZNZ3Hop47qOMj2ALa4oKnpsdTAQGGCjDNvC?=
 =?us-ascii?Q?3tWGagyWN1cuvMHTNj/AuOeXjgJkEtmyXxsRkK0MAOtJI39XRi+mOVuqaZzc?=
 =?us-ascii?Q?B0DcryJ0QgUHAyEf3Y0Glj1j+3Mumdc/jzfUb9vOA4q/yL16fbFiw9MuLjQG?=
 =?us-ascii?Q?OE+UvKtCdpUMw6jfM1YIRvWRJGLLa6/CQiBRypLeSgpcwpS0meAUbFF9Emz7?=
 =?us-ascii?Q?lGcNpqzsfB7R9W3yIHqxsf3KAiDkpLZg30nbOIIv92bPgmdbItEsWVOH2CVu?=
 =?us-ascii?Q?q6v5VZIg4bUmAK2s29RcF9MOHCtInhQOwcP7ZGB6/AfB983OQKom+ErlRmM/?=
 =?us-ascii?Q?o8vmRUfLag3dR2fR0ex1xlQwNc882sgtfqGwGSFyUnkH/G/7I/lWqjlh2Yyg?=
 =?us-ascii?Q?4Tpe2+zVfvcVsIDN0SN6KZ62nmshue02XDjPu+MFA+z1JxCNQ1Q3OmUpUOdV?=
 =?us-ascii?Q?LEP6syCKWlHlhoOHMWjNXzwQomMHtInTaM+l4DCb0qPtBv60a3Oxa/+77fTo?=
 =?us-ascii?Q?WdCfG1dZ5Gx/cM8A3kAae+B84lO4pAJWKfNDJFAi+q9bFiQW0r18qflTN8SK?=
 =?us-ascii?Q?IItafynDlzlP8KOFVSRJB5z9Fj9gx/eLwiN1uD1s97kG/NqeQ/aXWQ72wsYW?=
 =?us-ascii?Q?NPw7i0fyl2B8CXyG1HiYJ3zH7iZxX/8o2SN+5sFOe/uArRE00QXsfLihI8n0?=
 =?us-ascii?Q?Z9RPU+hX2kkMA0Yj7TX3H74mm2k0z2EvnqGstaee9NW1y033fPtJBNKaXVNN?=
 =?us-ascii?Q?bzo7yMWguZ9j1AR72lDBzzXAeKgYxrgxCqJSpLvrJY/95IfBUtrrb5a664WY?=
 =?us-ascii?Q?y/lIaTO5N8cIyaJB+doKr+XMXnrmQmqvb8x3BMH7fy8QC4LiCzDEsVUNhBpE?=
 =?us-ascii?Q?1bYEDYENnPv3HU878G0Dy41cbAHL1vv6waPOhkonCbzoVvf8JbQ32avKBX35?=
 =?us-ascii?Q?dytBQDWm4g/TkPwsjbGSb6noSf9FfwBvh+xOmFRcpR1M+pmvxavJw47IZcR3?=
 =?us-ascii?Q?9+YrA08ohthoYXk9JZOQf7C4qza3WYZhUw+MmQHx+AFMr5djaGjWCVl/UGk5?=
 =?us-ascii?Q?A/OPF9jo4nrotiZE/e35MBPSef8Acrjr9nkqffhKcamlB8+TyDz084VCaz6/?=
 =?us-ascii?Q?kepIocn0SvYrZ95bq8aBZ5U0+8ZMEOwPncAAKuZ9zPWxvnojK+jL7vwnKoGs?=
 =?us-ascii?Q?PUKZkbZOl9zEbSQvF8VAo5gbUdylFY+Dmb1vWmsh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d914a6-e3a6-4b8a-f59b-08daf31b7dfd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:01:03.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK27QxVN6+hKWqaXsCiKCECWgoQZgGOuLouefJbx7mKoVx6ZN+SR8oGzoaJAcgsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 02:15:00PM -0500, Dennis Dalessandro wrote:
> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>

Commits need descriptions

Jason
