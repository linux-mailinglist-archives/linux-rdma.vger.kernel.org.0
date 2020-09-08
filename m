Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45478261C85
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgIHTUs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:20:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7262 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgIHQBz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 12:01:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5790990002>; Tue, 08 Sep 2020 07:09:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:10:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 07:10:19 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:10:19 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 14:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP6OGnJ+hIJYVtVC5LJOOP4GjszbMGDvYkaPiRh6QsoZ8QT2+ilvFr5b6pXSDNJDUzItg3+q2GuFEOi+O0WyzKUcVpRhaQQ9ETilrFinz4xgsL9fC80Kczz1+jFY0Q8iaYzoKAI1gYNokJMvDildgvQi3+3/uE3oldjkGn6E0pdLGdpnVYVe0E2/VLYVcwCG4So1yINlPx+kOErsFRnhreoVY/ED/OPZ93/hjMSUXKqV+fNdiRszJaWmQ2zWRodrxrgv7gSggNnR0hwJnhZmouLGWzSv4RyZ1mQ3jqod7RQT72OJ5bFVDJVMmuEMdQtMVS3z28mXP+XgaLn4ktAGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESzgn3p2XJHD+FZkWR+pwoBLrcgxnzIQWrlfuHNACk4=;
 b=X6eKHrFlCsJ8XDkKady5D5t/Eetj6fL7+0kfGFXnoTaCSWaM5wikgyqZH26IHBFfQ1eZVGJxMSx1uY2oZ8VPbLInAgkXc8sWHsdCluBW0YcqG7gAvBUQAwg08cG20UTeKg+aq0EDUsC7C3+nRgxOD4ejN/I3ggh0T+ISNyUVS+JfYFKx/HV7PK2bVQdwXSFwr2DfZNA8ITHbjG8msrtVAEe1xPq47a9t0xjVHKt7qW+PbR/V2fZgRFDJjC0ecdoM5nHRDZZ8d42QaNlcfjQvcdP2DM1ivlqZqafD7k1qATQzdL+FGzbOrsz4L9SiiGMDIiRYqJ8OIIkCrKHUpY9cmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3015.namprd12.prod.outlook.com (2603:10b6:a03:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 14:10:18 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:10:18 +0000
Date:   Tue, 8 Sep 2020 11:10:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/umem: Move to allocate SG table from
 pages
Message-ID: <20200908141015.GF9166@nvidia.com>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903121853.1145976-5-leon@kernel.org> <20200907072926.GD19875@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907072926.GD19875@lst.de>
X-ClientProxiedBy: MN2PR20CA0047.namprd20.prod.outlook.com
 (2603:10b6:208:235::16) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0047.namprd20.prod.outlook.com (2603:10b6:208:235::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 14:10:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFeK7-0030JW-TV; Tue, 08 Sep 2020 11:10:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c090ffe-73e7-48bb-ebf4-08d85400e9f9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3015BBE807C74F962CB64C45C2290@BYAPR12MB3015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/IiPsTCMFwpWxv1dz92Uaei6b6gTSqrkh9DiBYYoV/gr7BSpEMCX6jDFsqytvbW60JPW/yO7dDt+mv3TknBo0/vAfm6MbSg3ix1SiPR/9nvV+RpsIRu5N6E8s7nPxRGBaO5dVb6MaEuDFET0mFfKrXZFywqpsmYe42v7NZFM9WRLkYSuF+rJlpHUyfoX9W2ZLHyW77azRzvIjmCCwQ3Eql8eok98p9IpBN7IwI7CvfMLEI4MhMI0sfqVQv+9MJDxT7Iq6SBhTsHRJbWKJrFo07B/DVxRg72SZj93m8VZFAxqc1tn7ZnMHqpnpPMBiNoOk0jXtruhY3FmqHta8MR3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(4326008)(2906002)(86362001)(54906003)(2616005)(83380400001)(36756003)(478600001)(1076003)(6916009)(9786002)(9746002)(426003)(8936002)(26005)(8676002)(33656002)(316002)(186003)(5660300002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AkR/sZRx/R5w1owjRDI4Ch+aDu+YdB+eEQ3H4WBN4IiezyTQkBUMP4+8EQ5qkPpMfw0E2CnwLdZn7PUAQ1m7HfPRV7gj1qs9+J90WMc9Auk8aAWDHD1NS1YXfjQM5aTI89aycGzeBZJmSs2JMfniy92aDE/eZG9TppbgIYbCGWhZIP4/UDCy2dBlp668i8xHYAgHelCA1TC5yi3bjnKgOfLzF5tIvCP+y32x3QYYdGlhLJ392zBiu8JFNfzhRdu+aTpb7OXaY68stSeCtGJJ/MFDGvyWxL1yCqyRWksvRnMvzhG66NTnMMYGuv1Yve8oj4QWMQ3o61WQkaQ0Kzjhix2r0oNi/zO5J11axYBCsJFoXj5AoqdAHqJYt2oV742oyLITtA/ANU85jUThdGegU7/uObYunbRyBjhSET9Bq02FKHRwboDTqyZpex3v8dpNFQKltGDVl0EzSKrrRo0F5SmJ6nFiVlOYaHhgy1Eq+ybNC6sQgguseqahPMc/g+rE0dXOUOCr7pS1NTR11xLh/QHJ8FuAzBBTSdaoVZyXYOgLxX6tvMInbmnc1C8Dg0B6jXIjGHRyfr+6jAz0b0sEXHK2Tc89gG1mpzalFUdPGdjsLMJGZ5rJG5uG1Oomz5Eh+HNlQE+z+Zkh4CGSsq1lpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c090ffe-73e7-48bb-ebf4-08d85400e9f9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 14:10:18.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/QchG1vHm93mPVy4dZTzTcdXztFOAZlFtkJUrC0Ioo4lY+cjkK6Km0BifQb0ibC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3015
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599574169; bh=ESzgn3p2XJHD+FZkWR+pwoBLrcgxnzIQWrlfuHNACk4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=MspOeoCCYrT+0OArT+LXLMUS1DVE+CNxq+uMagZLGEbOISOPLEecXZRP4VLGhKdy1
         RIMf+RID4emGmmAs7KFLPg0eMZmY+YukNTR9BpE1Q3ThavWd5gUsx0EQ8UJNFyy70Z
         Gq695S0Bv+4DwNQUmjLHTQipgYHFLsV+OcAqOY8wMHbP5QKlpKWxuKd++BKO3itvRs
         GLgh2RMK7mpx1Xep7KI7njVTDYs5rCJ4WoWAEeFNgTKLNoZjuerITWQJGJoLsml+7n
         pvVKsPYpFGjihn3nUy3eHiD2QyYbLwqO/dwc2x/n9xl7/6TQFKnm/0v+7ON0d9k4rx
         I0RmGVHWVwqyQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 09:29:26AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2020 at 03:18:53PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> > 
> > Remove the implementation of ib_umem_add_sg_table and instead
> > call to sg_alloc_table_append which already has the logic to
> > merge contiguous pages.
> > 
> > Besides that it removes duplicated functionality, it reduces the
> > memory consumption of the SG table significantly. Prior to this
> > patch, the SG table was allocated in advance regardless consideration
> > of contiguous pages.
> > 
> > In huge pages system of 2MB page size, without this change, the SG table
> > would contain x512 SG entries.
> > E.g. for 100GB memory registration:
> > 
> > 	 Number of entries	Size
> > Before 	      26214400          600.0MB
> > After            51200		  1.2MB
> > 
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Looks sensible for now, but the real fix is of course to avoid
> the scatterlist here entirely, and provide a bvec based
> pin_user_pages_fast.  I'll need to finally get that done..

I'm working on cleaning all the DMA RDMA drivers using ib_umem to the
point where doing something like this would become fairly simple.

pin_user_pages_fast_bvec/whatever would be a huge improvement here,
calling in a loop like this just to get a partial page list to copy to
a SGL is horrificly slow due to all the extra overheads. Going
directly to the bvec/sgl/etc inside all the locks will be a lot faster

Jason
