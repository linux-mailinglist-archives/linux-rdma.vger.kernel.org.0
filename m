Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539C25B41B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIBSxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 14:53:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6356 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBSxh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 14:53:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4fe9b10000>; Wed, 02 Sep 2020 11:51:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 11:53:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 11:53:37 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 18:53:36 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 18:53:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAveZg2HB0PAlEyBdBRXA97Sw/hLrGF1ObM9lMoMXa78zJxEXlUa+7fj0yVNqqVaxN2VqJRz9xqebvZtsPmQNlPAYHNj/2oZECjy/3gi/tZtKkvzndG21hvDjO1GiMe8J00yjy3XsKM1D1+X7NIOgZnkgZuzVzcbIHt4YRRHXtA80BLReYvFlaxv/TyvQjfs8HAH1/4FBWa5sUNgJkxBDTlTqQfJqbnh5J3F8kge0XthLWfr7ac2Ar4pgdOlfVasQN560QPT1T0ElT9gu1HfAEpymCvliIUPP5seciICw2SuUxXXdWOvieda7v7p2sTVSKEwa80ayLsbTluPDxTY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiOeRw9KrQtXtbzasE1WYLYuTna/lFS5YO6KuQy78ag=;
 b=nuu9cSwT+9iVJPtAYGJ6ldeAEQN+mKW710fqxEQrKgeV3r3dEOyKFc3A0yu0v19mVcHDWX5OQvUqINUZCXGuGhCK63WOWBlSDAEzi67l2HtiiEiUzw8q7rbQJWgU2KKnJtz8zURH1mYqxJfD8Le/tRAhXeEY1GEvfPHAESbgOIvFv6Uet8iYcTTmrz++m/sN7lvyIOch95NMOv8t/J4YpidiRXiqTLoTXiCvrHNJaktyrToeryRRFEPxjX7KNMLRUz4SjN3Re9cF4bWH6V4DiXV98URugHi8FWZfUDtQ14a/Ui2r5lnsBrttke+8X49KiafM7AXUiruOATgBMoo/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 18:53:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 18:53:35 +0000
Date:   Wed, 2 Sep 2020 15:53:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-rdma@vger.kernel.org>, Stephen Rust <srust@blockbridge.com>,
        Doug Dumitru <doug@dumitru.com>
Subject: Re: [PATCH v2] IB/isert: fix unaligned immediate-data handling
Message-ID: <20200902185333.GA1420661@nvidia.com>
References: <20200901030826.140880-1-sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200901030826.140880-1-sagi@grimberg.me>
X-ClientProxiedBy: MN2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:208:23b::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR11CA0015.namprd11.prod.outlook.com (2603:10b6:208:23b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Wed, 2 Sep 2020 18:53:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDXsz-005xay-TK; Wed, 02 Sep 2020 15:53:33 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbcd0c66-9150-414e-2a1a-08d84f717efe
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34024F9B7FBD58BC59C337B4C22F0@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJtB9AXg9rjKqr4I32hb1ZMZPHW1fpyuTdtwq+bk/6SxuCeALtHFq7iDPbn8VjQrZHs7UfUr8RRnBYGtpwUWigoUgR3hLZLiNnHdpHF5JoxW2uc2VJe23YGapgQG5NC47P4kCpWWvtsZIdevCQW+yC5GJu2XazXNVO6lG5wscLikP77yKdylWmGH5WRdMXuKh17r6HbyZqKDOffyynxf0ICmxBsmdIJc6hWI+CgY7TciFufLrfcjSmghIw7ZFkTV1gpjgxFq98FbKB2pSeJY9KERAGC5/4JajHukppX7m8+1zMsXF6qsV6WmLCFPN3SWdPQAWyvXOa7tBJR1HRxjTootGm4sUcmEcIdSZ2zYL1RpGLTYzp43DY10M0GEQpJ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(33656002)(8676002)(66556008)(6916009)(66476007)(8936002)(9746002)(478600001)(9786002)(83380400001)(66946007)(1076003)(86362001)(2616005)(2906002)(26005)(316002)(36756003)(5660300002)(426003)(186003)(54906003)(4326008)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AKnFNB4Bv4BEd4jnpCJ4n1WeUMJWmTMf+A2JbYxtp2Z7G3UfSuIyot+hpSRZ/jzeLzxfnvWfHfQZCx+KLyy8ZLg626gX4b99cURmutb16+eAFEKg6sFQEQOPU9/20+X+Qk97FqpgvW4+rCMcj8TmUVGAIui59rG6u6KIZTX5EslbM4R5AsH8u5HyGVrziQ4yJkpw5QdbRbQRFsWYrQg7iAc+MQ3UVgM3OygyCcD7vhZI7G3wUR/onRnKp0+JMDr65hOpPd2IPpbvQN+EasAZemma05m8UWMYJpI/RLpH8uDiNSi8wXYyYGtpLCV8AMAScz8O+OGDQuBlnyi1LLihsy8E/w95D4amNAabB0Ni4zZ+hmsL6R7TQvnu3gXk5/ObByJrmk6PUAWQVScPj1SLjcpmVLpCnwFTjhORZflcP2MpkWvFvsrY+fcXWSf3jjNy94h8SAJ2byldx/D9KkaZTofSQMKISRuRHYe01BYaAQzGT4kZhAF5KG+VM6Pk1OzbyTqYOmUUugvsf3Qa/QY+sy7EUPEquIdm1j9vniTG5kiEIN38Ue5vNdwovGfqKusNqUPmd4RJobRHWNFb0I0U50aDwpMriuriJ8xUjk+ZQozN34zIYQ5+Ajjw6PVMpS0rY0lm0pg6i+0HFfehMC8Vgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcd0c66-9150-414e-2a1a-08d84f717efe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:53:35.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpkYj8eUJImFyO/KNXZwnrAyrh2joN74wWN61avakeQNeQ2TlJ1QYSW9zmtNa/XZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599072689; bh=WiOeRw9KrQtXtbzasE1WYLYuTna/lFS5YO6KuQy78ag=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=XcEiCIeb5fyN5TMqaoW6k4HjF8Vku3cMBt59LMF1lnn/GiRnRqRFegW3jubRBEMHn
         gWYyEo42VVAsTOj7ReJqq0NDpCMAtAu+iZMMIQZlt2Q9vn9qgxoqTvg1rZvWXny8mG
         +tY6gI3JhXLTSLSXgEzW4AMUR7ow9R96mLe+WMUbS+mFLzuelAi/RVqrU7W5dLTBG1
         TWp4bBdgAsHQ46yM2e8bineiHg0yRijlvHbKfCVQsotPx2FkfaVgn+PqMxgsNfmm56
         ENwpJPOuHQndcxJlxs0+2yqUvt+1cF3pr+AKqdUM8V0Tq2qH+vo47J6CboklmnIlSU
         ym9fsoc/7ZfUg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 31, 2020 at 08:08:26PM -0700, Sagi Grimberg wrote:
> Currently we allocate rx buffers in a single contiguous buffers for
> headers (iser and iscsi) and data trailer. This means that most likely
> the data starting offset is aligned to 76 bytes (size of both headers).
> 
> This worked fine for years, but at some point this broke, resulting in
> data corruptions in isert when a command comes with immediate data
> and the underlying backend device assumes 512 bytes buffer alignment.
> 
> We assume a hard-requirement for all direct I/O buffers to be 512 bytes
> aligned. To fix this, we should avoid passing unaligned buffers for I/O.
> 
> Instead, we allocate our recv buffers with some extra space such that we
> can have the data portion align to 512 byte boundary. This also means
> that we cannot reference headers or data using structure but rather
> accessors (as they may move based on alignment). Also, get rid of the
> wrong __packed annotation from iser_rx_desc as this has only harmful
> effects (not aligned to anything).
> 
> This affects the rx descriptors for iscsi login and data plane.
> 
> Reported-by: Stephen Rust <srust@blockbridge.com>
> Tested-by: Doug Dumitru <doug@dumitru.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - revised change log

This still needs to identify when this regression occurred for
backporting, what is the fixes line?

Jason
