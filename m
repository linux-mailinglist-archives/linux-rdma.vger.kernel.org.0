Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E87A887A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjITPez (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjITPew (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 11:34:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1817AF
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 08:34:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c0ecb9a075so55602725ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695224085; x=1695828885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20j30gzDNaRbJ5xUKBMXdbzYyvNH89R5nkbFfjN8Hm8=;
        b=CPqkHoEwDzOswEOwDQ1CBeZ1ogbmeACj0BD+AbKvjmecBPHnCezZJAZrSDZDlUU3Mz
         FM2NyijF/YhFMF+wj+Qc5C7uYFszixzRDWRY+Yn3Bn3Cpv42GpVFCZxogQFZOT4dDBhh
         u2Q2LbToa8TalK46YSg3+kr8GMZ3LCA0S3XxhxVaKucA9noq39V561jVXPduCHNDVUuz
         8vDYrvvowT2xCYy7G8wIPRDewp6HtXIe9JatEHtwqgZJAXy4qVWvkkOXfXr3JYAIgDbu
         AYUx/emkcBK2uP39CgcN4Doa3lcMyTAYoQWoOqLZIH5Q+kdNQoI2zAJ9OL/tC5d739Uv
         wO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224085; x=1695828885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20j30gzDNaRbJ5xUKBMXdbzYyvNH89R5nkbFfjN8Hm8=;
        b=CY00/iKK0xiUtBrQJzMUHjpDpATyoJC10RXKmtttdjUqmPDjT+aE6RjXNR9qwb+LBH
         h4jxZXX47jWBRlm67CcA2SRAmCSeEhAEhRIQb2IASVGS1jy2DWxlJrEqdWMdlNsCuyWQ
         kWzogqwONMsfsA8+29EpKdLOhJkLcYw1Ae/m/YOIhce2frsIrFv7vtkPGNJHlFVb/gEZ
         H8o4tWyBRgi6QtzWX2iphIfXYfO0k5ALgiWwWjTVjI+ajdVVcCZtEXByxTrTkzZqJfl8
         q0hVlfRLrlhj6VqqM4zdifFlxYSszSh3LR9XEm2tLrDzZwt+C9mXU7J6xgGgYhdBiSU5
         X6oQ==
X-Gm-Message-State: AOJu0YwhSM58kWioLPvaaOw//x1USQ55Yu/e9mvU78zogd94OiPOYWR+
        QMB74wKEdQSKVId3/yYG0Jkm4g==
X-Google-Smtp-Source: AGHT+IF06h9LF0wrDEyrnUuEVNMIeXcK1BIdLn85c7xpqfoVS7ch60zFQK+PU2v74BZ9ydWBZHBg7Q==
X-Received: by 2002:a17:902:bc4b:b0:1c5:64aa:b969 with SMTP id t11-20020a170902bc4b00b001c564aab969mr2264430plz.48.1695224085390;
        Wed, 20 Sep 2023 08:34:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b001c0c79b386esm12014133plh.95.2023.09.20.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:34:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qizDu-000L43-Rj;
        Wed, 20 Sep 2023 12:34:42 -0300
Date:   Wed, 20 Sep 2023 12:34:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Message-ID: <20230920153442.GV13795@ziepe.ca>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
 <20230919081712.GD4494@unreal>
 <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
 <20230919093028.GG4494@unreal>
 <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
 <20230920074753.GJ4494@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920074753.GJ4494@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 10:47:53AM +0300, Leon Romanovsky wrote:

> > >> About this problem, I think we discussed it previously in RDMA maillist.
> > >>
> > >> And at that time, IIRC, you shared a link with me. The link is as below.
> > >>
> > >> https://www.ex-parrot.com/~chris/random/initialise.html
> > >>
> > >>  From what we discussed and the above link, I think it is not initialized
> > >> fully.
> > > 
> > > I remember that discussion and it was about slightly different thing:
> > > {} vs {0} in Linux kernel.
> > 
> > 
> > Well, in my mind, I thought they are the same. see: https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html#Initializing-Structure-Members
> 
> It is GCC specific implementation, the original discussion was about C-standard.

Yes, the C standard says they are different constructs and
pedantically only {} is required to fully zero the struct, padding and
all.

{0} says 'zero initialize the first member of the struct', it is a
terrible construct because the first member may not be an integer,
don't use it.

Jason
