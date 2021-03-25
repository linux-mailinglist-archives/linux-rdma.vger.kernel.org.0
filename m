Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22E349451
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhCYOjw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 10:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhCYOjb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 10:39:31 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B9C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 07:39:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f12so1791882qtq.4
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6iXLF/lKSG8S51IUrl5KoCZW79Du1xNlnz6N6/Diyn4=;
        b=mJ0/eVxlyR5iEOAhqAIyhEp8iJaZZoKGL9mo9LeKqskmGim8MQCxW/vE49ORAaoi9o
         PYSyPhswm0JKFEdhb2Q+Msn5dNWpQJBZnN68QL1gtHEoVfoDDZ+JM8YytOH/ndrRRfhs
         SS5GuFcdsYqRucVnpe+73VvdEXaDMO9FkqfT7xoydiDq52yxko+FDCssdThCAQWzrHPv
         mR+NCglz5hvRmMcjf4JwDMsqX6SjzbOTDsPMAp5X5lr9FQ4iYmpxz/q7/pQpAk7ABkBR
         q12p0o/PM0ucHPgv9YP3K8mFlB63AboI6/9zSnuBpCu6V4s5KNgxz6Ed3rbZTVa2gjDB
         8Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6iXLF/lKSG8S51IUrl5KoCZW79Du1xNlnz6N6/Diyn4=;
        b=CN0+PZNTMpEsI9L9zpiMzJJcqzEON5Gd3Si41U4RSkHc/j3FnO+RbJ+EfRXj9Y5oVu
         VsDln1o/nMff7nM3ejoibQdagtvDs9qx1xS1V8uaP14rknANFmFqjybZ21kQRQrGHHLR
         7XYnuygmUXPbV3lAzhewwIz3epWP+OlvKYPuGQ3YFUqSHitTNjdJ0NDYU++u2i5uGoB0
         1OJZFrg5cA/RtpRd0fS/MJw9S0a3iFa75SWF3XXMXWs57BLI9IrqogPlhV/zqqQDNj7q
         ACQTDj+XXSO2ZUBmx7osutxj924JeGhMmFVC1yTZOcbxB0exMeghK0ZRejx+iPEXckhf
         enUw==
X-Gm-Message-State: AOAM533FimHum7GhVpDTraYkUgDJdn6/uZxduc4g6gvgRnkxRWBV7fHL
        rOyhgMNSiKEYtf4++N35rpiGEw==
X-Google-Smtp-Source: ABdhPJxZDMo7r+XfXWQKy6rexnqyaa+VI9LcE8cZzoNWbcySugAq3xtJGYmwPJ9UloynDbQAf0RQ0Q==
X-Received: by 2002:ac8:5e8a:: with SMTP id r10mr8045937qtx.13.1616683170204;
        Thu, 25 Mar 2021 07:39:30 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id v7sm3536639qtw.51.2021.03.25.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:39:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPR8y-002fsw-N6; Thu, 25 Mar 2021 11:39:28 -0300
Date:   Thu, 25 Mar 2021 11:39:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210325143928.GM2710221@ziepe.ca>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
 <20210323231321.GF2710221@ziepe.ca>
 <0DFF7518-8818-445B-94AC-8EB2096446BE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0DFF7518-8818-445B-94AC-8EB2096446BE@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 23, 2021 at 09:27:38PM -0700, Aruna Ramakrishna wrote:

> > Do you have benchmarks that show the performance of the high order
> > pages is not relavent? I'm a bit surprised to hear that
> > 
> 
> I guess my point was more to the effect that an order-8 alloc will
> fail more often than not, in this flow. For instance, when we were
> debugging the latency spikes here, this was the typical buddyinfo
> output on that system:
> 
> Node 0, zone      DMA      0      1      1      2      3      0      1      0      1      1      3 
> Node 0, zone    DMA32      7      7      7      6     10      2      6      7      6      2    306 
> Node 0, zone   Normal   3390  51354  17574   6556   1586     26      2      1      0      0      0 
> Node 1, zone   Normal  11519  23315  23306   9738     73      2      0      1      0      0      0 
> 
> I think this level of fragmentation is pretty normal on long running
> systems. Here, in the reg_mr flow, the first try (order-8) alloc
> will probably fail 9 times out of 10 (esp. after the addition of
> GFP_NORETRY flag), and then as fallback, the code tries to allocate
> a lower order, and if that too fails, it allocates a page. I think
> it makes sense to just avoid trying an order-8 alloc here.

But a system like this won't get THPs either, so I'm not sure it is
relevant. The function was designed as it is to consume a "THP" if it
is available.

Jason
