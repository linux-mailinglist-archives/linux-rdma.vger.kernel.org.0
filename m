Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEE718ACF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjEaUJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEaUJj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 16:09:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D6126
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 13:09:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso60179a12.3
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685563777; x=1688155777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znL7f7/82TkQpJEpu7c6MThFxiycg/NL4+PI0rygfNQ=;
        b=JumrgGYStYR+yRW+DXolW6jOJL2tiwPHpWi2FK4VDTy23bMMuYYFyPDEr0CfUZ8h+e
         9sFBsOZ8J/nQK5TMW4TK6tkZAqqWcZJhqNGRZLUbA8NcAcgwbLQTBr10tqD5zuxLJPcH
         b0A9Jz36cd1n/nSsRKoZQmRUB4+6FhHECdanzUDisr4M+BgzGJ5b4GhmXgT9ZTbNngoh
         9yki4DFFHBFEeaQEwvxsITXKXFgJIFSUaLMLu7D+76JpvoFnPSGfWliPOGCi+ZKjnM8e
         MIYjNo0q3R6ia1zLKhqW4hUa2VkqPIEPBgHKTRotq/LbmV1eOsYrciQUcSZheqAnyVt3
         qvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563777; x=1688155777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znL7f7/82TkQpJEpu7c6MThFxiycg/NL4+PI0rygfNQ=;
        b=TJJ3xxsfh0pfKFdup1s18yj+xALj6+laKv/H01ecgkEVkK3HDmh+hL8K0xJiuie1Dg
         F0MWhIZAzeteKF+dCEknNb/zP+UKZpEKe8SxWMW1GvC3+7AdQlVbBOTTFNvEoO8oMZCt
         aYSOshmMYREtca5HuvbO62Xn1EuKDgBjJ/GBZWyeiVtsbaTWgYJDLFr1AQcIPxVEffS8
         pTFM3SsHpuNqQ8W438cIfCpmh6MUs8g3aMyMTNUuGpFxD5NACbYZmmAvs+y7zlqCTHNK
         CHRcy2w1hRlR/URoJ2SqBxW6yKCNCsOc3PT4UdhdfK8hanTt+HunBeRq78j11u63Asvj
         8Dmw==
X-Gm-Message-State: AC+VfDwadNS2TL/JMf3VLDb9BW9yBrcZVtsIK7f1jXJXjwlJd29Wf+Zo
        VDRrSiQHoeC04QBJnR0cbPjRBg==
X-Google-Smtp-Source: ACHHUZ6eKWw/t7H+nBTQPpkqQG0FdVwCQvVKNUD8kXL3Dt30mSh2odKjCoBtWWk9rwAIB4uAOMdlGg==
X-Received: by 2002:a17:902:d2c5:b0:1ac:5b6b:df4c with SMTP id n5-20020a170902d2c500b001ac5b6bdf4cmr6534057plc.69.1685563777563;
        Wed, 31 May 2023 13:09:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001b04c2023e3sm1767799plb.218.2023.05.31.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 13:09:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4S8V-0018Kh-Pk;
        Wed, 31 May 2023 17:09:35 -0300
Date:   Wed, 31 May 2023 17:09:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Netdev <netdev@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH RFC 3/3] RDMA/siw: Require non-zero 6-byte MACs for soft
 iWARP
Message-ID: <ZHepf6/z8ZxRPe+B@ziepe.ca>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
 <168330138101.5953.12575990094340826016.stgit@oracle-102.nfsv4bat.org>
 <ZFVf+wzF6Px8nlVR@ziepe.ca>
 <7825F977-3F62-4AFC-92F2-233C5EAE01D3@oracle.com>
 <ZHeaVdsMUz8gDjEU@ziepe.ca>
 <B0D24A4F-8E82-4696-ACE1-453E45866DAC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0D24A4F-8E82-4696-ACE1-453E45866DAC@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 31, 2023 at 07:11:52PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 31, 2023, at 3:04 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Tue, May 23, 2023 at 07:18:18PM +0000, Chuck Lever III wrote:
> > 
> >> The core address resolution code wants to find an L2 address
> >> for the egress device. The underlying ib_device, where a made-up
> >> GID might be stored, is not involved with address resolution
> >> AFAICT.
> > 
> > Where are you hitting this?
> 
>      kworker/2:0-26    [002]   551.962874: funcgraph_entry:                   |  addr_resolve() {
>      kworker/2:0-26    [002]   551.962874: bprint:               addr_resolve: resolve_neigh=true resolve_by_gid_attr=false
>      kworker/2:0-26    [002]   551.962874: funcgraph_entry:                   |    addr4_resolve.constprop.0() {
>      kworker/2:0-26    [002]   551.962875: bprint:               addr4_resolve.constprop.0: src_in=0.0.0.0:35173 dst_in=100.72.1.2:20049
>      kworker/2:0-26    [002]   551.962875: funcgraph_entry:                   |      ip_route_output_flow() {
>      kworker/2:0-26    [002]   551.962875: funcgraph_entry:                   |        ip_route_output_key_hash() {
>      kworker/2:0-26    [002]   551.962876: funcgraph_entry:                   |          ip_route_output_key_hash_rcu() {
>      kworker/2:0-26    [002]   551.962876: funcgraph_entry:        4.526 us   |            __fib_lookup();
>      kworker/2:0-26    [002]   551.962881: funcgraph_entry:        0.264 us   |            fib_select_path();
>      kworker/2:0-26    [002]   551.962881: funcgraph_entry:        1.022 us   |            __mkroute_output();
>      kworker/2:0-26    [002]   551.962882: funcgraph_exit:         6.705 us   |          }
>      kworker/2:0-26    [002]   551.962882: funcgraph_exit:         7.283 us   |        }
>      kworker/2:0-26    [002]   551.962883: funcgraph_exit:         7.624 us   |      }
>      kworker/2:0-26    [002]   551.962883: funcgraph_exit:         8.395 us   |    }
>      kworker/2:0-26    [002]   551.962883: funcgraph_entry:                   |    rdma_set_src_addr_rcu.constprop.0() {
>      kworker/2:0-26    [002]   551.962883: bprint:               rdma_set_src_addr_rcu.constprop.0: ndev=0xffff91f5135a4000 name=tailscale0
>      kworker/2:0-26    [002]   551.962884: funcgraph_entry:                   |      copy_src_l2_addr() {
>      kworker/2:0-26    [002]   551.962884: funcgraph_entry:        0.984 us   |        iff_flags2string();
>      kworker/2:0-26    [002]   551.962885: bprint:               copy_src_l2_addr: ndev=0xffff91f5135a4000 dst_in=100.72.1.2:20049 flags=UP|POINTOPOINT|NOARP|MULTICAST
>      kworker/2:0-26    [002]   551.962885: funcgraph_entry:                   |        rdma_copy_src_l2_addr() {
>      kworker/2:0-26    [002]   551.962886: funcgraph_entry:        0.148 us   |          devtype2string();
>      kworker/2:0-26    [002]   551.962887: bprint:               rdma_copy_src_l2_addr: name=tailscale0 type=NONE src_dev_addr=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 broadcast=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ifindex=3
>      kworker/2:0-26    [002]   551.962887: funcgraph_exit:         1.488 us   |        }
>      kworker/2:0-26    [002]   551.962887: bprint:               copy_src_l2_addr: network type=IB
>      kworker/2:0-26    [002]   551.962887: funcgraph_exit:         3.636 us   |      }
>      kworker/2:0-26    [002]   551.962887: funcgraph_exit:         4.275 us   |    }
> 
> 
> Address resolution finds the right device, but there's
> a zero-value L2 address.

Sure, but why is that a problem?

This got to rdma_set_src_addr_rcu, so the resolution suceeded, where
is the failure? From the above trace I think addr_resolve() succeeded?

> Thus it cannot form a unique GID from that. Perhaps there needs to
> be a call to query_gid in here?

So your issue is cma_iw_acquire_dev() which looks like it is encoding
the MAC into the GID for some reason? We don't do that on rocee, the
GID encodes the IP address

I have no idea how iWarp works, but this is surprising that it puts a
MAC in the GID..

If the iwarp device has only one GID ever and it is always the "MAC"
the cma_iw_acquire_dev()'s logic is simply wrong, it should check that
the dev_addr's netdev matches the one and only GID and just use the
GID. No reason to search for GIDs.

A small edit to cma_validate_port() might make sense, it is kind of
wrong to force the gid_type to IB_GID_TYPE_IB for whatever ARPHRD type
the tunnel is using.

Jason
