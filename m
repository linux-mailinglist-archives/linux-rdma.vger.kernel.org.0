Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A873244C46
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Aug 2020 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHNPoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Aug 2020 11:44:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1871 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgHNPoR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Aug 2020 11:44:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f36b1410004>; Fri, 14 Aug 2020 08:44:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Aug 2020 08:44:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Aug 2020 08:44:15 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Aug
 2020 15:44:14 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 14 Aug 2020 15:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCpupBCIPFLA6XU9fI17jSux3QUZQA3/G3jQdhgGDLCe7Bjlc4dFX3jraWu6jUKz0FDx+TAaQZQfRwf7ykVzkyY15tqRu0GKgsP8Dlxzb6rdSK3NAyx/oJG+F7RcgW/1tjVyuWZMq1L6lpIANKwOJqBFxH648ksis9dl3GFwK5SZEfAhclMH4e8PYavUMljI4SKlPd3b73iBLwyrmSWF8hqAdT5dvi4Xte1z95Ga/T/XbdvMmA7WVteI0em1ka95eu16v25oXuz3udnVAdJM0CP2hY2OtCPXzToM5O7BY2152pY98KckXLV2jebnMaHdZy2lSUOujb9RYr9sR5/mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NlEhyEorvI3w+Fcz+iPcjcwJQeE44y8E969eQCWecs=;
 b=id0TFmFtl3YL1dwQLPTnrhXgymFd/xQIap9fMdEoOFKZJEhPS2Ra6ectzSzjkAzNFEHD9TNFVR46fCbdtYuphmEBdN09hf93UD/EE+2lIh0t6CDLYklrxKVs3ajw6A+YHhneQSLyldw/X1eCXjrYzby6A/J46iw0z93e69rzQToAgvKLON+lKgWFmLYESQkuRzco63IQT61E2LW3nTn8o1kHcHkh0niivXnAhQJe3xDP+x/Vz9sfCqTpmkt1SY3IFRPIcN94/gZ1Ewxf73ZcO/9Oy4koqI7QqAvOrIYQmG/vWYG9Medi9TeSGMM8HXckijjGu03DlUjW5/Hlv3BKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 14 Aug
 2020 15:44:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 15:44:13 +0000
Date:   Fri, 14 Aug 2020 12:44:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>, <linux-rdma@vger.kernel.org>
Subject: Re: Is there a simple way to install rdma-core other than making a
 package?
Message-ID: <20200814154411.GO1152540@nvidia.com>
References: <75bbc81e-cde9-c8ac-0ba3-04bf17b8d5fa@gmail.com>
 <23cc5656-882f-f8a8-426c-ff065cb0b969@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23cc5656-882f-f8a8-426c-ff065cb0b969@acm.org>
X-ClientProxiedBy: MN2PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:160::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:160::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend Transport; Fri, 14 Aug 2020 15:44:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k6bsJ-006j7f-Gw; Fri, 14 Aug 2020 12:44:11 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9643ac15-a598-4b79-6412-08d84068e4c2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107B82C34E52037A55FC075C2400@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kO+k8xAwU1TSB9GjaFq8a0c7TuBrH8GNJb3mgDRFbM/9jey4k4HiOcqKqczOWoU0ATTohpdGMwQPxLqSoeI8/kWnkDo+/irSdhXUVaEGEYcCFPNcT010MSAQRA4gcVSf7gTOVZFUr2dB6YiSSClSd+XZAYV5xfKWD6F1EPeTp/MScqs+2TpG9UYIEJKrpOL3ojjK5LZKUgXVNIwybE0xn/YwowUo1eKTflK+o/uCbnGFCncQbJRdkzpYPakdxpSiKKxbthnrkM/Z+BFIAdaQSARRO82tire9RAO9MGzR3TfC9g63XhcrbLN4NnXFpXoNVhrN8eqt7c6sCBhs9Y925UrbUvEC8q6179FGtyPFLLsBPafZtd+oPkcptgSsodtqyRtBQm5/4WO1vLN5MSirg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(478600001)(6916009)(8676002)(33656002)(36756003)(66946007)(5660300002)(8936002)(53546011)(4326008)(2906002)(2616005)(86362001)(26005)(316002)(9786002)(9746002)(66476007)(186003)(66556008)(1076003)(426003)(43043002)(80883001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Y+pTEdqraySxb979AkTotf3czSu87Y5hA8ZdCCbeZDhx4JP9LjrYL1xrEJUNH/ZExynBxcmox6L0dJ8NRDlLDkMaOojOIh0qaNhvaOwD9zoLLCWEKAOIgIgNTcCoyz5n4zNQL2YXZMxLKLAIm8NyziXqP54ZvWYN7fkBChzA2mPcB94zaiOXVE5i6TeDfhZqtrLiDh/3xPjy8xPMQh/QI51voTMHhkzeDp6HroNaWVlNtLexuvjS1aDxM6gv7rUkcEbxOCAkpvmpjoMAHSqyjhyuC66BX7tDbL0BQK+VNv3vdcdZ14wPk9zURfu6mp4sPYbfQfeCTVpY33Gcl+1vqgMiulDqoun8lXFf/3dOrbWWugqt6tn4SlMWUjlD3Cn2VnW1xpqB/WTNpxTZ2Ai1r9SAoG59bwdIJaAeadZJvvNerAbGDtRMh3GslmqXIFxCRELuw3/UFuIDnUJz4AV9Fruu4MHAM5kSUq/4TuUEN5OP+RYU7Gp50GbI7yoE1YWGe3nkjj4GxQH9f13UKOaXTJKts4+7nVw7FRMWAY/WWAmXwQzmzj4dFouPT81MdoxoyaVl5E+RlLZfo1TLITKIsjt0hrXlbpzm4LU+I4P40Q8JWDC0ffoj+aGcTFS7frOiIvD541eJsiJI8KPsASFGVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9643ac15-a598-4b79-6412-08d84068e4c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:44:13.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqOEj18UNdh6HM5UmbpmKbzsFDf5g5PVe4EQgkhaqvP1ltgNbewkmz9XOmojzYKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597419841; bh=5NlEhyEorvI3w+Fcz+iPcjcwJQeE44y8E969eQCWecs=;
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
        b=HXQidcTotwX0R6YD4xURns4sQadZb/9WlhNYGIHGmamcx/0iqZEe6p9RdbSp6tz2d
         qEHXQA5bHx6GmyY6Q8MAgPHJokJIBs4Mv0zJMnTrtNmVzKf3mZ8erzcOzAbYrbwjAD
         sVUhad9XDYVoNBbY2ZKrRFTUHrnujepa7AmhKLVVGeYYevRYdDWvZvGkshoOR3TSo7
         GEOvAnwVT0O5Cw07jemAImkMEPjihLjtwrUqOIENOXU2ATDgUjApN0Mi5aYBwuagK2
         nV8ipGY4kvAaSRtDEGSbPSZswKMjur5tJLHGLEArdGbyfeDzP2Awtc16YqqrE/a1l/
         Hpx0gy+Q2Insw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 12, 2020 at 10:14:17AM -0700, Bart Van Assche wrote:
> On 2020-08-11 20:41, Bob Pearson wrote:
> > There doesn't seem to be a documented way to make install rdma-core, at least in the README file. However trying the obvious
> > 
> > $ bash build.sh
> > $ cd build
> > $ sudo make install
> > 
> > seems to work, almost. After a few 100 lines of promising output I get
> > 
> > CMake Error at librdmacm/cmake_install.cmake:76 (file):
> >   file INSTALL cannot find
> >   "/home/rpearson/src/rdma-core-git/build/lib/librdmacm.so.1.3.31.0": No such
> >   file or directory.
> 
> This is how I do this myself:
> 
> export EXTRA_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1" &&
>     mkdir -p build &&
>     cd build &&
>     cmake -G Ninja CFLAGS="-O0 -g" -DCMAKE_INSTALL_PREFIX=/usr .. &&
>     ninja &&
>     ninja install

I really discourage using 'make install' - rdma-core is complicated
and adds a lot of files to the system. It is very hard to undo 'make
install'.

For most things just set LD_LIBRARY_PATH=build/lib and just forget
about installing

If you do have to install use the cbuild package builders and install
the RPMs. At least that can be undone.

Jason
