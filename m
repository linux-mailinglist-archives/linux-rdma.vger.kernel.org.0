Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4A39BF08
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 19:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDRrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 13:47:21 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:34656
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhFDRrV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 13:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH61Yb031EgOVEzzhohNgW8BnWJkUZ7nDl4K4J5goGBwTVJRLwg8VQvMf91I6E+EqYS2gBIfPMg8XypjgnhFc0AanQIVNiB20z8/XtKKKcjbIze3jDXWk/bi6/0I4HnJx/iXld9TocSnDw24tOw/DMXQdKlBAL8eQrbKtANgKE3xW1LJJvcWySZHFJBhd1Ni5zLnMBy1lJ8oj1TOGFheTBIiiou4rUCCLDlY/RF6NKB5CaGC6SbaEOieTHPcJqYeGlH/QKWHmLj1Ky5FUAPgNsoqt0V0+tfqAqY/YQV5sMJ2j5RV6oGDiW0LyNd/FUtmB82SqAzDdwoJeKA9TRMysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFB+lQ38t7ux/rirrU2XXUujfHof1JeiDVhQ16xN29A=;
 b=TKZ/fYeeH6AA4CNQK/8GoffxunAdfJI47T08OboBW1fwfn87G2AiN8r+W5hM7VfKZAr3BNZu/Uq0JjT7dE5f8FxtHkEUgKvASb31f3UQDAgDHmzfcHFiGIpLynXQIz0FuKDHd+tdt84wyLrgB8Gs5AtTyqrBsdaXPW4ySh6GxyAh8iNdFlNJBxIfYn4EhoULZ5n1HJBrMadPzgnGl7kzRqIEwVO4A+nZNUHh+JaNDQGhTvWCy0M+ASqp7/tImyqS3mquxWDYG673NaB32RKypQv7rC1NqCqdH9sNpxtiCD47ELpeKBd3nIwbWFmPQkPOp0EIKGrrg/ISOQNUHF9W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFB+lQ38t7ux/rirrU2XXUujfHof1JeiDVhQ16xN29A=;
 b=H73CyHFLzeALBUjKda1ZMrh7zeVtSiQjpp1hx/W4f38IcKvihQ3tkCjnrOud7eJTXM/WFvNaonJf0GQ8V8EVeHYDp6PeU/XYHAS1Tl9ZS5x+qhsw0ScQxZt4SHPfNkmrQbwkafI3mu9BQZt3tcrkg4yFfg2GO5nOZphBoOVkOrMELNva8LhBQXg7lB/N6lhzugNPkUOYMEDnMig0JF7zRxjwwq6MyuMzSH60GwXr3m4tet7I9dfMRjAWqz/2ghLAHXm7NpBrYOaEoNzAUIjJSTSbxBczzGJieDVGk5BCndd5aprZ2DN+xa8pHGwSIArJsUsEEt26lsAUdfsae2e0pg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 4 Jun
 2021 17:45:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 17:45:33 +0000
Date:   Fri, 4 Jun 2021 14:45:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH rdma-core] docs: Add a contributing.md
Message-ID: <20210604174532.GW1002214@nvidia.com>
References: <0-v1-b00db5591f60+96-contributing_jgg@nvidia.com>
 <YLpI6e/62HFuZl31@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpI6e/62HFuZl31@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0309.namprd13.prod.outlook.com (2603:10b6:208:2c1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Fri, 4 Jun 2021 17:45:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpDsy-001mEg-GR; Fri, 04 Jun 2021 14:45:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61911ba2-c72b-4f0a-9671-08d927808d77
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206F537A571C892998D4C8DC23B9@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bU9DxZdMdy7Ckg2uumkcfvaQyd3iXv0zBnTDavV72Xl1pv58fea/uPbpzuErJdFcJ06hCzNzFH2UPjYgjdoSTVxhrhy/DyLf6ijpeUrT5MKEhLITNaYcuBbP4k2JJGjwNTSk/XcTo0wOcuZYiFu7xGD265WmH2bbp/zQjyS5hLc9IdB3PfDEhg4xNHQbJcXTcAutOsx2MmwZhK1nJNz+5YMmxQ5gc+b8uFhPTzoDyb7NoVsvUMAEquit0pvSOQ9pIiHieKUT7L6Owrunc9+/+uRM54vzj5v2Q5AqOo8UBo7T9oVAApc/wrX4VRsZaT9e5MYH8hV1u2Q2iN2MCbzqCYzE91gfvemhqVssDPJBewhRgk7mJ8jPLCF1qLu73Y59DB92cI1u0FZ2KNF56Wx2OSgjtTcG2DXnyodLFo890nydI9OgJvYssxO2DZat9UCswve7MMEpUYcoWPO8BznYW877d1xEQ5SUvCyCeJdb1hBN6D1Ju+lcRaAsCx4Mz0wzar9bmKqQaYD7h4jdnr/TvIguUkiZb9ZOL3NRZfP3tWq0j0CLlH6+S7zW22zRU27KL/K6X/1Bf94sC8uxVF/+h3RWxx83FcqSNU1sFVnd8j4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(426003)(66946007)(66476007)(4326008)(66556008)(186003)(86362001)(33656002)(4744005)(478600001)(5660300002)(2616005)(2906002)(6916009)(1076003)(36756003)(38100700002)(8936002)(83380400001)(8676002)(9786002)(9746002)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jrL0Otc3jPNWwYerVkxerBr/LWWPqDEkOENZ3W59W6dXx5kvnkWS7TmiwbET?=
 =?us-ascii?Q?YjKlSfP/H9c7QnLaB7vCSy1e1jGUXsq1YOcqdx9iuVYbE+VAewPqAlaxJkZ4?=
 =?us-ascii?Q?oAOmd2ASJT18ilWR08zSWWFDPSCKGVSF5ipS/10kPY0cNb1vH142PQcfi72z?=
 =?us-ascii?Q?vqNYdCgPbMEjKBPXRBQIdPPynTqUgBuXtc97pfxT/JbeQ/QUEKF3ttAPiOmc?=
 =?us-ascii?Q?QV6LFq6PavAUHwk+Cs14/PpsR7hg0/wi4NDPNxcz2c5y0uBQtGj0Wss4AWc/?=
 =?us-ascii?Q?Y0nt3OAPrrLFkoVElIBNRqQAnZvpjEUBO07HhGBd7fvCCXgS60yO2lVSNTk1?=
 =?us-ascii?Q?TuRsmTLAIZRUnpy4ZueeByS8Zp0x7jMrwpMaS3x0xxM0wwoHFp3jORkWEpcm?=
 =?us-ascii?Q?HgFA1OI/5uJOApcakkkNR9twviDhg9khg31KHvApIVWjiz7nyiwkEZZdY5fm?=
 =?us-ascii?Q?XFMtiKAGnskjZkULLUBsOEfqjvduM4B+5gRHYL7R6gDg8D6LIkwP1CuCaVb+?=
 =?us-ascii?Q?GYrLKRMeFDvZqOeVUv1j7am8qwua3j+ti9n02OkGZVCc/acemKNlZAF+nBa7?=
 =?us-ascii?Q?MCeXvDe/duWqp+bHc8DzhjqNVpgJlkx+41xb89iRAnX39i+1lYQuh918u5yu?=
 =?us-ascii?Q?0rJW2SVQXmH6pwU1/L6hPtRZX57Wef79pzBanERvJZE+WJNhq4/keI/XZWJb?=
 =?us-ascii?Q?z1YAyrZBDEoLpVas2Yv4TycHwt40fmI/iNJNk72v9t7vQIvpxLkbp5UtPFRF?=
 =?us-ascii?Q?yBhU82t/ApE/zO/yIF6pfZzVqvo7SYCegTZFIqzLwHmM5m3ADdhJOkmXq4A3?=
 =?us-ascii?Q?83IJ/5QSPchRvDPWVy00D4flgeb2TUlt4SvsPHf/VYRw6jwLm3rYnHxcQAws?=
 =?us-ascii?Q?sSbvN9soOQVV0Ad+UkIfiajJJdyyat1GvzIAmobUKfSDJc604MElN+jA8zzg?=
 =?us-ascii?Q?IKaX+F38JK96ITiUQ/FHTJgVsuOvLgoSz7CqT9oju9W0w7vx5T6IbAbbnYsR?=
 =?us-ascii?Q?478/0+RC3fRd0Zu/sDyIclximSsVnmvJH24RkzQmATP2A5dow6iYi/0l6v0d?=
 =?us-ascii?Q?9Uyq6iGhD7ROkjUzOjKt5UYrDy7OuMc7pPFfdDKOZoYdOfpmW944Q/T+kgwq?=
 =?us-ascii?Q?8jFH1LZ2YOAcyeu4dfbuZ82crGbe8tBZ1iOwv4GmFpKbd/f+CC+UC4PiEsnx?=
 =?us-ascii?Q?vrK+iStmPoVXiykiWSDkaaV4MM98So/5cjaeQ0VWaLRlO4/4HJYEnHgcFHFo?=
 =?us-ascii?Q?faKCMG+Qj6+hLzxOwOosZ9AHWEmyx8zQ2NGYx0voHEZB2LsuooZNcadssa16?=
 =?us-ascii?Q?AFEzLnTpyvzqBIfmChR7vhBK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61911ba2-c72b-4f0a-9671-08d927808d77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:45:33.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoL74jGVaRoh4RG3CEs+9myPVtIsP0jyRecFaom/FPep1fGsgvq1E7QuWF6Vdrrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 04, 2021 at 06:38:17PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 04, 2021 at 11:13:02AM -0300, Jason Gunthorpe wrote:
> > Discuss how to use GitHub properly and document the special kernel-headers
> > process.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  Documentation/contributing.md | 164 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 164 insertions(+)
> >  create mode 100644 Documentation/contributing.md
> 
> Please update README.md, it has "Reporting bugs" and "Submitting
> patches" sections.

Done

Jason
