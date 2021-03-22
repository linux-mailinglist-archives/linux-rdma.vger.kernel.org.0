Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2720F3444A4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCVNDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:03:18 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:7712
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231760AbhCVNBJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 09:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By1n7WaNHhJog+FX0a8ZxO3ouB46fyPv73vGh+s34wX0oGOXr28c/+xuc2TncfxvuomUL/zQdHS4z24lO4bgiI+JeTs1bZc7iqxWME+zsNJDM5TjSAI7I9zwZJ1tqj0MyJNCjlDafXBvC+ot+3FITA8UUpBrPspFOzNq/sI26Klkm2Gh2q5yRg8qgSu1StnkQciQCBswVEPqBOUXM5HDQV/rOgP9z6S6zp2t1v9kLxGYnBmIyiqBHuUmaiMShSbydFAKPOl79UPkL/YedrmTu9TI5jU6QXhoLe9dlBf+F4vtwMTqqWDHyUQgao7iUMAsLclTY5E7g1dkGq7a/sBt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+1Z0XKVNvI0LWhZbMXpry7FmZ5UdlUFDXMWW88x8t4=;
 b=NFOuWRLEy7kNcfVez2DapD0UfjBAHfSPOH+nA+ltDyGUJbn2rGgm0DVuO7dpNEgiwFxiVuVCdKXJJ1j+YjDJKNaj7G3c+zC778H7cyk3yZabPYqEg7gs7DJIWjMZqvSnwK4g1tLBJV0QxGhor0Tyg2IeqTDa6GbVieQLFKRgOr5uKz8vd+MXc+rTGTrMq7VMEBZ/GM1uHFLlXKmfIETX/6dUkloYDIXFgPh4LFjCBRP1bVfWQZ95Y6IFsWiQmB1ZLgUECP9OGQX36BYcK+2oZIEs1vXAP5VtXaOsmfpJ2vJiDI/DzsDP7cRJXrvdzVvNuVgtZ1sxLmsWeoNJYrqzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+1Z0XKVNvI0LWhZbMXpry7FmZ5UdlUFDXMWW88x8t4=;
 b=TiqQtcuk0KZxbL0uCkSmfw98NLw/FQ7lBLDo88vTdWUCdjFKigrXjAP+tZZcpjrnJVuq//8LX/ZjN6ca2OzoCLJgx4CTF6RZU2XJt5lQrOOgZObDR2EqMt9puB4uFKknxwLxiNztkPtT5yI5VEOZyV3MbYEK8UfrrX/Jyh5UibsCYQab7AS+ewb66cZzuR9o5hbPka3FM0JlBG0HDxeZvMbDtXaWBamsIngPg7m5W/94oPpcGbh7PQ3Bn5colWiqr4ZvUOC/0+Dq152MwFoXXKrbmDGrOS35g8FuKDPWglR35vGefZwqsmA2EqYPBO6Q5/Yasp0BYijDnFA2AvjyYA==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 13:00:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 13:00:32 +0000
Date:   Mon, 22 Mar 2021 10:00:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/cma: Remove unused leftovers in cma code
Message-ID: <20210322130029.GB247894@nvidia.com>
References: <20210314143427.76101-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314143427.76101-1-galpress@amazon.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:610:cf::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:610:cf::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 13:00:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOKAX-0012XW-Tv; Mon, 22 Mar 2021 10:00:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f517c7-d60d-4d11-abaa-08d8ed32797b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28579C26D17CCF544511823AC2659@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UA3t1dN2Xk4jFqb2iINjLhWiCcjunKginm1yzUhnsTumNSUD9Ao6IjYyrpPjNPgfHdbDzEUyNWCwSvfy0hZmai82uTSCQLwaaYcGvQq4N/n2xhAU0wNWWG23rTMuTlaI+uQOz1w2AjGKP/hse599/UImjKUbK0dzWiYdUjc8kWOHlyqJoWWECmWG9wlN78ec9DcvYGh06jgyUP7rJ95GwNNHhIPkcSql/N5r3FF8M3C3KRzfwZdL3ChEalE4DUP2r5DlfrIinlWRELvpp58WhYB6ix0WSf7ujWZYLVqZ5eXVg5xcHs7g//71A4gcenQ8ZoEsyYM0LRppMnHfEw4fh5+98a1JbTZ06v4SzblJhmWuGQM+fJEbaidXY3LvkEwkEc2Pm5wiPBIg/4e2x/+nd+Y/sHwDkRdYvyGzvraE6rbQmwws/Lo+75oZvY+D1fp/b4VG0GHC34Yab3XSajwYdDDXKQFwpznODzQSUXNvuRHPFqPilky8TLt2G46d3rC9u3808yhnrxc5574R7QArm+IXBC7Mm+KlsZrDJgjSvk1xBNr3FTyuhCh6tmxZX6LKq+jbhp9hrAX+QiguGM3v8YxggVs5nsH/O1SWRhnzkLjM1Hob3L5n+dzOT/ATSebbBya0WKSohCLwtyewjJp80QrhtvBMalukaBQLyi+JTN3RLwQll5MUH0rsEl3fvh7f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(9786002)(1076003)(186003)(33656002)(66946007)(66556008)(8936002)(316002)(26005)(4744005)(36756003)(66476007)(2906002)(9746002)(426003)(86362001)(6916009)(83380400001)(2616005)(8676002)(478600001)(5660300002)(38100700001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GNyHqUyxEtnYZn43fT67fHBPXkQROMOJUCQlcvW+9m8mrP1LFehMMNT21zC8?=
 =?us-ascii?Q?ACFIxTzJ++PsV6vZIIEAFfo5FYu0k/H451oHDxLzLj4m0u20YHOK0tGWYj8G?=
 =?us-ascii?Q?wwrOo7em8VtK1jpqHLxPM8+2Zqk175jjISXen5e/X2sbuFaGQQzIa3Wnb1fs?=
 =?us-ascii?Q?23chAW0VBuNhqdwgUEuVffoF3+OE0L+vcL0L+ZDWty5eW9LFo8bz+sHPP50D?=
 =?us-ascii?Q?uTo/KehB9ZkN3cuSjZrx3kAP9bIKrEtGhuRs6wu7/PTu7e6rzLyeyZPfQyZ7?=
 =?us-ascii?Q?iBONTDqCtmbLqo0cL+1qqpa2hhMQdjmCZOB6qSVOGnaCDt4FPOyh/fO0XRyK?=
 =?us-ascii?Q?O5iPh6zGkYbuHVoXDfy8u5aSHzVNVU6XhQKLpcNthr5hDytTMXjU8U9GSDLA?=
 =?us-ascii?Q?HOdVe83WZ1lC/y87Yks20Ktu1e2zLgVEdgAJEp7Anuu/zF6yQG6lnSpI08zT?=
 =?us-ascii?Q?OPMiT2A/cjDxP8/4EqF3s6/nEjNucx82bk/Rm2R6FsX7OL6EUJk+OZ9BkmpJ?=
 =?us-ascii?Q?wXSDXnZo1eA+wcd0FAe0u/vNtcZfqmiaEMlOxubF+vtbql9hCUFFDWrc7TA3?=
 =?us-ascii?Q?QBmrR9j6Dle+6rbKQ/codbwX9dRMemNmcPqx2JvYPUuP6g72AreNUZCApq8N?=
 =?us-ascii?Q?AHtrgRW/MzGMVyb+JfHirPz9DI5WmTuBKNDnoeVLNttdn4pAxdT3WF175IzG?=
 =?us-ascii?Q?M6bWLTRqZYhOvY2cNX+eW0C4AE4n/XJw0RecmBB2jAAFJJButQDTH1reIVWw?=
 =?us-ascii?Q?ln9W2M2QgRDnlFM/Ck2sM7yG/x4b/wK8u6Xy6qP24AuNi/deG4/T4CBPbWCy?=
 =?us-ascii?Q?CEkSUSmsw5ezjYvqgdSs8vZvuilYaqCsl/GZqXy99U1HCwAu+hzoBWgbMrUa?=
 =?us-ascii?Q?VgtnvKqPggoXxSnPE/KXCEF75lKPXHToefywo/PK69x0n6cyjZMMVtpO8mpA?=
 =?us-ascii?Q?XvinzqfHO5NTM1XQmWt63ax47HM/JBsrVTLWlzrSxsX/SVXyLD5A+scOE0NA?=
 =?us-ascii?Q?KfNQsaaLkpeZLJG2oraoID3XD1Nlinabpof7MP+CTNETF2j0mJXH+2c+/7j7?=
 =?us-ascii?Q?S93xU+K4JfRN7XQszlzSdmSK5SjPVkin7BeQ7KLXJ3DhnSTmikpaRWPCIsGV?=
 =?us-ascii?Q?PZNnriayWjjPaQ2QnSvLwdx0b+bhBe/8U4dmYWaFr1J8HRipD/4pSSQGmmzf?=
 =?us-ascii?Q?22qbNAmMxHtIJSPHGnoO2Q/7mTNC9B2Qf+8SDDWlsazYlhvp1JrTft1p3VJn?=
 =?us-ascii?Q?EcQ+vbx+tBLdtx9e2wT7Rp1P9a1Q4HVnmdf+HHBnRZg6vnIxi9R/wwA4FLCP?=
 =?us-ascii?Q?F9ReFc6v7pgYJDYMndXEDvWg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f517c7-d60d-4d11-abaa-08d8ed32797b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 13:00:32.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/7/uGNRR1PssiaYT0sIhWdCGPSbu5dtHlO/abijlwRQ31jBd/8xPUozVxebrZYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 14, 2021 at 04:34:27PM +0200, Gal Pressman wrote:
> Commit ee1c60b1bff8 ("IB/SA: Modify SA to implicitly cache Class Port info")
> removed the class_port_info_context struct usage, remove a couple of
> leftovers.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 9 ---------
>  1 file changed, 9 deletions(-)

Applied to for-next, thanks

Jason
