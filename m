Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE6154B9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEFT5A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 15:57:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43805 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFT5A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 15:57:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so6415266qtp.10
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IapbnG17HnRAI+fgjIuaulp9CMBvFm3VLGbRmGWF4E0=;
        b=kh3j8pzeyTDmGdBdKT2t6wK4qJrWUxjJXhSIbeCddOyLk5cEpXkW4F9N9u/+Cu+JYe
         CcD+9uc4Qg7Zmm+P86rKLNxNIuzFyN0OzWfKQtI2x4PixE0FH3kFcVFuPlLo/Ompqdu9
         w7+GVG9UeA0IbgDDhWr88xyWm4uNLGrNLbYpVGiEWxcRPBo++VUOVJcu47sjlyVVwUeI
         /0fW1+foLI2m//cXq3yGitHMCceBcv6YhtnWyMBhfj3Qw3RiebMP5Bu1VTQl8/Uonzn0
         1GwiYltb3AemZiK8e09/6Yi5+nA1kCdB43L1rD1DxX+XJ+3W+eo5S6qX5BUXHAcD2WAl
         qG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IapbnG17HnRAI+fgjIuaulp9CMBvFm3VLGbRmGWF4E0=;
        b=cN79mgYXXVG7G/xfkorIa1MQp81wjU9E+WmeoaiimR9rtD6zfI4JD6zNHOAY3KzEX2
         Fl3HzCtvT6LD2XS7IsUq49Ro4MtZr+/1hW58nuUPIbhBXOTwlbhXRzeEaeYqSojv3uPv
         NVTm9qUc29UcjPVzBufK5jSzzN6TCgGZGL+TKMwziD8Fai+u9W/z/i0nDowHMSkTNVal
         HaGfXYTqaT+dnlNcIxZLYKZ1QcgeaLpBAGBjQCWBF60WZhqSA0OuQMZw19Yk/ZNF8kxf
         OCfET3tvecKj0QY8MimMSO4bg3oPGyUSxVAId+fz5KUCzRsmQkrkHfpUsLXAyzTmViWK
         yHNQ==
X-Gm-Message-State: APjAAAUSajh2E9Z2/pKY2Jd+JbcSMuCDsH4GGxSKb+6kYvPzLplTPKoB
        rNLUPc1x5/A17QxFZX/mA/rhWg==
X-Google-Smtp-Source: APXvYqxjdKr8Wo1ZXFmZHUCUSuh1O7kFe1C0/S4S/tUB/aC2ePJCp7gcnSCWSFy1sqGqg62USpuzhA==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr22216670qvf.132.1557172619424;
        Mon, 06 May 2019 12:56:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id h7sm5794217qkk.27.2019.05.06.12.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:56:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjjN-0007sr-Dg; Mon, 06 May 2019 16:56:57 -0300
Date:   Mon, 6 May 2019 16:56:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     jglisse@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190506195657.GA30261@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411181314.19465-1-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 11, 2019 at 02:13:13PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Just fixed Kconfig and build when ODP was not enabled, other than that
> this is the same as v3. Here is previous cover letter:
> 
> Git tree with all prerequisite:
> https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> 
> This patchset convert RDMA ODP to use HMM underneath this is motivated
> by stronger code sharing for same feature (share virtual memory SVM or
> Share Virtual Address SVA) and also stronger integration with mm code to
> achieve that. It depends on HMM patchset posted for inclusion in 5.2 [2]
> and [3].
> 
> It has been tested with pingpong test with -o and others flags to test
> different size/features associated with ODP.
> 
> Moreover they are some features of HMM in the works like peer to peer
> support, fast CPU page table snapshot, fast IOMMU mapping update ...
> It will be easier for RDMA devices with ODP to leverage those if they
> use HMM underneath.
> 
> Quick summary of what HMM is:
>     HMM is a toolbox for device driver to implement software support for
>     Share Virtual Memory (SVM). Not only it provides helpers to mirror a
>     process address space on a device (hmm_mirror). It also provides
>     helper to allow to use device memory to back regular valid virtual
>     address of a process (any valid mmap that is not an mmap of a device
>     or a DAX mapping). They are two kinds of device memory. Private memory
>     that is not accessible to CPU because it does not have all the expected
>     properties (this is for all PCIE devices) or public memory which can
>     also be access by CPU without restriction (with OpenCAPI or CCIX or
>     similar cache-coherent and atomic inter-connect).
> 
>     Device driver can use each of HMM tools separatly. You do not have to
>     use all the tools it provides.
> 
> For RDMA device i do not expect a need to use the device memory support
> of HMM. This device memory support is geared toward accelerator like GPU.
> 
> 
> You can find a branch [1] with all the prerequisite in. This patch is on
> top of rdma-next with the HMM patchset [2] and mmu notifier patchset [3]
> applied on top of it.
> 
> [1] https://cgit.freedesktop.org/~glisse/linux/log/?h=rdma-odp-hmm-v4
> [2] https://lkml.org/lkml/2019/4/3/1032
> [3] https://lkml.org/lkml/2019/3/26/900

Jerome, please let me know if these dependent series are merged during
the first week of the merge window.

This patch has been tested and could go along next week if the
dependencies are met.

Thanks,
Jason
