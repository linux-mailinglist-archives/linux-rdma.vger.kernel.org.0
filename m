Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A226E319C
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Apr 2023 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDONf7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Apr 2023 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDONf6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Apr 2023 09:35:58 -0400
Received: from out-15.mta1.migadu.com (out-15.mta1.migadu.com [IPv6:2001:41d0:203:375::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4287C3582
        for <linux-rdma@vger.kernel.org>; Sat, 15 Apr 2023 06:35:57 -0700 (PDT)
Message-ID: <5deb96d9-31bd-1455-ccec-898a821aae01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681565753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ih77L0d4Msd8sH7VYfpXBgYu0/Mi6Rt0BQ2SdxlyfIw=;
        b=wbH5bTbOPn2suysYaDoknSKMhnjfL8BgE+y1gB72wLp1KrR0dAfHVHu+ZZy/t/Hoi0hf0d
        Pd/jH/tEYD5iACf7gcHqgGh3mKWwhDFzJv0TAeCuDtSr9gr9qObtV8xutOqKfZpj34J1bj
        EQlvCog+UwChbIg661j9JWhfyhXMm0w=
Date:   Sat, 15 Apr 2023 21:35:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net
 namespace
To:     Mark Lehrer <lehrer@gmail.com>
Cc:     Parav Pandit <parav@nvidia.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
 <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
 <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
 <1adb4df4-ee14-1d26-d1ac-49108b2de03d@linux.dev>
 <CADvaNzWqeP1iy6Q=cSzgL+KtZqvpWoMbYTS8ySO=aaQHLzMZbA@mail.gmail.com>
 <PH0PR12MB548169DB2D2364DF3ED9E2F3DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXm-KZZQuo2w1ovQ+-w78-DW5ewRPPY_cjvprHCNzCe_A@mail.gmail.com>
 <PH0PR12MB54816C6137344EA1D06433DCDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548134FDB99B1653C986F30DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CADvaNzXDBKiXi5hiaiwYh5_ShqW_EVBfLhwNbk+Yck8V7DQ-fQ@mail.gmail.com>
 <PH0PR12MB5481CA9F5AE04CE5295E7552DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <29e1ed5a-091a-1560-19e5-05c3aefb764b@linux.dev>
 <CADvaNzWfS5TFQ3b5JyaKFft06ihazadSJ15V3aXvWZh1jp1cCA@mail.gmail.com>
 <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CADvaNzUuYK9Z6KdP+x2_qX4vhJ_GV5U1bHsYCqoxxP=MGjfbGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/4/15 0:24, Mark Lehrer 写道:
> Apologies if you get this twice, lindbergh rejected my email for
> admittedly legitimate reasons.
> 
>>> If you are in exclusive mode rdma devices must be in respective/appropriate net ns.
>>
>> After applying these commits, rxe works in the exclusive mode.
> 
> Yanjun,
> 
> Thanks again for the original patch.  It is good for the soft roce
> driver to be a "reference" for proper rdma functionality.  What is
> still needed for this fix to make it to mainline?

I am working hard to push these commits to mainline.

Zhu Yanjun

> 
> As an aside - is rdma_rxe now good enough for Red Hat to build it by
> default again in EL10, or is more work needed?
> 
> I'm going to try making the nvme-fabrics set of modules use the
> network namespace properly with RoCEv2.  TCP seems to work properly
> already, so this should be more of a "port" than real development.
> Are you (or anyone else) interested in working on this too?  I'm more
> familiar with the video frame buffer area of the kernel, so first I'm
> familiarizing myself with how nvme-fabrics works with TCP & netns.
> 
> Thanks,
> Mark

