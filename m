Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050E12F19E8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbhAKPn2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 10:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbhAKPn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 10:43:28 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02AC061786
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 07:42:47 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id et9so7557061qvb.10
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jan 2021 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/A3K81mCc2dS4hJrTjzDKAgCNXohBPbNHXt40jMVfBE=;
        b=CXrZBuSkG8rRms3ZL3rzrzAOF3aLMpWdW69IPOtx//RbSUIhNTMwQ9FMK2nCPInD+D
         ZX6cGJzj5moC8jlrzTKKUXTa+JR/s9PdGesy9OId/yTn+wN2+ciOgS20FwZdZnOo8DHI
         DDQuWmu5xvEtMw8CoTvnYScPHMK+9GCQG3WIAmdmvpnqLHvMHDjdfCtQvFm4aHNt2yQA
         +AWVRQ5CFmmaTTXp5IiZFgYht1+EQbPJB228B4YDjoUBWtsDZ22ZUCFOK0BzORdcm2Cq
         hw6V2zIS8PGacVXd9RLe4Zr7FiYVQX9y/qDTs8XlKHfiSfVcTLLIiZXTapof2a/I/qOi
         8/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/A3K81mCc2dS4hJrTjzDKAgCNXohBPbNHXt40jMVfBE=;
        b=WaFcgiXSofYEqo9Cy/q101ClefxClIEqsA2n91aO2ZELAH+lHzAurNw+NcYm5Rwe8r
         aoVN7+nEpNVVNg7p1xKlFfDlj9i6Qf8XQRCNdWCudjsyoYsKGWIOKizIu6BXGQxnPEQG
         cVZ8hn0eJ7wcwYTbw4VjKLzMIXFgVKMKB++1OK1a0TKsIz4tuNfdpwZXWawAq3rFvVuh
         6tv0v7WouuLRWWMk6ZHmAIpL5/mwF7lYZartudaSFdrn4Rl7ToTyzU2n8rsZzYgofqx+
         NJNvVrpVh6MfQn31gnIrUqrqYSZRUO6aZ5kf/jOdGMwND/jHEFWxyN2QT/mDFQDj139a
         DpDw==
X-Gm-Message-State: AOAM532BOHRzPVqe7vHjAKuC7a/Qm/rFME3V0w9CWa8QZhnwXA6efZ19
        e13HRfAeG2H5BdqWGaCKJlRNpA==
X-Google-Smtp-Source: ABdhPJyqWR0zrhRhfIJaiKsvRsyRi99Jl6vsxixvOPVy/qex98L1qLKA8+KCmL3Ov+yPPxwU0W5tvA==
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr262417qvs.12.1610379766360;
        Mon, 11 Jan 2021 07:42:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id f10sm8111748qtg.27.2021.01.11.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:42:45 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyzLB-005Xz6-9o; Mon, 11 Jan 2021 11:42:45 -0400
Date:   Mon, 11 Jan 2021 11:42:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
Message-ID: <20210111154245.GL504133@ziepe.ca>
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <MW3PR11MB4555CCCDD42F1ADEC61F7ACAE5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555CCCDD42F1ADEC61F7ACAE5AB0@MW3PR11MB4555.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 11, 2021 at 03:24:18PM +0000, Xiong, Jianxin wrote:
> Jason, will this series be able to get into 5.12?

I was going to ask you where things are after the break? 

Did everyone agree the userspace stuff is OK now? Is Edward OK with
the pyverbs changes, etc

Jason
