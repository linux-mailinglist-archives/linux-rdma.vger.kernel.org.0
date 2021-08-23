Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4233F4BB8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhHWNaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhHWNay (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Aug 2021 09:30:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48245C061575
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:30:12 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so19120956qkc.4
        for <linux-rdma@vger.kernel.org>; Mon, 23 Aug 2021 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiHglz2EY8QDYgMKUpJAtBm7Bedun/lz5hf8S1a2TMg=;
        b=J2BXURbQJH2t6xMjGjPuzr+/wLSTXwFMvWrj/R74S2ssA0fyE3SGC1IaQ+wnhIXhw8
         mxojhX4JdZaDwflGodye4g0JaT2Eapodfz6HCizkjPcNy0S3ZQesOFpo3pKj4dWQOSuf
         73n7bhcUusqxvV3ztCCQoTqr6UYQfJvto5YxUWuHoeRMhx/JS56csXPzSYBxgZC+BFhj
         pgJuuRMrhLukw9sK0H4ru5mo0GxxY4JzDGogXTuud16vPcqlYnm0cccfeNrJnox/kCTo
         LUXl3cz8EZBBe4tVvN8fbZlquVMnUpwf/Ulm0uqk90NNzdTtX8z2qj8Q/zkOsmnQ/tD+
         r2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiHglz2EY8QDYgMKUpJAtBm7Bedun/lz5hf8S1a2TMg=;
        b=svYH55XGHo/zbTskJKjhizhLXEE5mLoa+KLtwdSFNsosW+AQ9a8dKbilKCJKq5DvqU
         zGYo+c9n/9aT3e3OxvUkYnYjSz5bj6f62wZnJW6YutYLU1pNjryqYk73XR+q3ylyjLOB
         zkt2fD/LGlJwsp5Uo39s0Hg8u0FJQkeyG7quoX9qrDnxjTUz+HRSreUPWH6EkkjpNhmd
         /PiiKscPOnaOqdvWg4es7vo1MW7FNbJDRSzna7/s5rsfh5+NBdhF5kc4nyKjqaLTnx6b
         3UNhJ9N6udRTNZ0MhEPfBI7+y5kT10E+oduBVmx3fW4gPkZ3JeL0InWHd7cWmtXxrmpP
         W5Ng==
X-Gm-Message-State: AOAM530DtXpQd/ubWGbLyKq2xPDjj2SLg6cbtmOuDsdcxXTJio6+Mo9B
        NLKGu5Kywy7yCfUc9KACTOIc9g==
X-Google-Smtp-Source: ABdhPJwzNpPxMshC/u3pXWpxLpYakZeurzN/oooBKFPoXApUWrSO/N24Y1GmqI8FwEWovyvn6wVCRg==
X-Received: by 2002:a37:c97:: with SMTP id 145mr21079914qkm.121.1629725411505;
        Mon, 23 Aug 2021 06:30:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x29sm6292631qtv.74.2021.08.23.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:30:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIA1i-003GkZ-Cz; Mon, 23 Aug 2021 10:30:10 -0300
Date:   Mon, 23 Aug 2021 10:30:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Misunderstanding of spec?
Message-ID: <20210823133010.GB543798@ziepe.ca>
References: <63A948DF-4EA1-450A-BC84-D12B1C59E7E8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63A948DF-4EA1-450A-BC84-D12B1C59E7E8@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 14, 2021 at 03:03:52AM +0000, William Kucharski wrote:
> I noticed that under certain circumstances, GID 0 for some interfaces is reported as all 0s, or empty.
> 
> This seems to be correlated with code in drivers/infiniband/core/roce_gid_mgmt.c in the routine
> ndev_event_link(), which does this:
> 	
> 	/*
> 	 * When a lower netdev is linked to its upper bonding
> 	 * netdev, delete lower slave netdev's default GIDs.
> 	 */
> 	cmds[0] = bonding_default_del_cmd;
> 	cmds[0].ndev = event_ndev;
> 	cmds[0].filter_ndev = changeupper_info->upper_dev;
> 
> bonding_default_del_cmd will result in a call to del_default_gids().
> 
> However, given version 1.2.1 of the IB spec, looking at page 145, line 20:
> 
> 4.1.1 GID USAGE AND PROPERTIES
> 
> 1) Each endport shall be assigned at least one unicast GID. The first unicast GID assigned shall be
>   created using the manufacturer assigned EUI-64 identifier. This GID is referred to as GID index 0
>   and is formed by techniques 3(a) or 3(b) described below.
> 
> 2) The default GID prefix shall be (0xFE80::0). A packet using the default GID prefix and either a
>   manufacturer assigned or SM assigned EUI-64 must always be accepted by an endnode. A packet
>   containing a GRH with a destination GID with this prefix must never be forwarded by a router,
>   i.e. it is restricted to the local subnet.
> 
> 3) A unicast GID shall be created using one or more of the following mechanisms:
> 
>    a) Concatenation of the default GID prefix with the manufacturer as
>       signed EUI-64 identifier associated with an endport. This GID is
>       referred to as the default GID.
> 
>    b) Concatenation of a subnet manager assigned 64-bit GID prefix and the
>       manufacturer assigned EUI-64 identifier associated with an endport.
> 
>    c) Assignment of a GID by the subnet manager. The subnet manager creates a
>       GID by concatenating the GID prefix (default or assigned) with a set of
>       locally assigned EUI-64 values (at GID index 1 or above).
> 
>       Each endport must be assigned at least one unicast GID using (a). Additional
>       GIDs may be assigned using (b) and/or (c). Note: A subnet 2 shall only have
>       one assigned GID prefix (non default) at any given time.
> 
> make_default_gid()and add default_gids() seem to have that all taken care of.
> 
> What concerns me is the code that removes GID index 0, as page 436, line 35, states:
> 
> C10-2: For each GID Table, the first entry in the table shall contain the read-only invariant value of GID index 0.
> 
> So is it actually OK to remove GID 0 when removing default GIDs via del_default_gids(), or should it be preserving GID index 0 at all times?
> 
> This is because it appears a call to rdma_query_gid() (as in ib_find_gid()) will return -EINVAL for a table if GID 0 has been deleted.
> 
> Am I misreading the spec, or is there a bug here?

This language can not apply to rocev2 which does not have a default
GID at all.

Jason
