Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214865FF40E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Oct 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiJNTV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Oct 2022 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJNTVz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Oct 2022 15:21:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA6205C0
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 12:21:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so3113211qkk.10
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHBpp35mBVwsHVLSYA6FANhXEKaMBA8KY7wcN8nnXps=;
        b=klzSJn8cqBUwbjJx9pep8jedDrL8msz/rovlbMBoKkw2fIG+8ahO+VRYzJr8cAtiXj
         UKN+R6/M0XNqBKJxBbUUWPV6SP0JIwW+QAvTr4BvRRj8TPsSMkMKgc61fsS2Yy5kHCdg
         sNdTUvhUsm5p4PG2yukZXI8mQCsBquEwrY30+yjAWe4I11ul69hIs8eKWz+O60kcR8Rr
         m4MFAV2r+nyITenuH4g6crPndaS+5R3G81zBGrArEWMpnUyg1a5D6jJRMK4WL/IRmOjF
         /KSng/KtvZq133GmNp8aumHfgfnwByu9TlOgwocdpCk4skyWXxDPrZvppgz2Rqu9tZdF
         76pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHBpp35mBVwsHVLSYA6FANhXEKaMBA8KY7wcN8nnXps=;
        b=mh2TWFQAES766mdapvJSd0YbWjKboBbhoa/s2raXs7uNyM3/bpduB2KQreJK6vQPTg
         FxzThx1GVKljArJ4N7BxL0YryOFhEWVozJ/n+VAkDAkM1kVYbRlj2XRFoToX+BBOZyTU
         BqMgkJpT9BJBHG+3LbATcqkFMXZGtqp7iIR9NwDIlA13EcjGZn4wlRo4LHvqu5E4rEpQ
         HR24ESlhW45i1aRiTY4WCQxIkvfQReynSztCiP82wqPGG/9lRWI5KSsxFiDHt/S7vbq0
         p3yRSE0/+q1djQZ5iZ6xwfPcVyH5s+ViwLUd7pljpAg8+A+usgiu3b1JSIlUzS9mYgNw
         hsAQ==
X-Gm-Message-State: ACrzQf0zGwjdDFD3RM0ATiWkUNYL+wv7ePbesXrx8fRU6VJGXP6L1d+j
        ZafniSO2B6HImHoirU9sanJX0Ycpgqb6qA==
X-Google-Smtp-Source: AMsMyM6kBk1fJPMrOIWFOcCDLf/UrbkEv18w0AKoGr79nLPAKUYcIj1x25NQKCz/v+3ZqAYqHAzikA==
X-Received: by 2002:ae9:f80d:0:b0:6ec:52f0:f2df with SMTP id x13-20020ae9f80d000000b006ec52f0f2dfmr4895816qkh.291.1665775313293;
        Fri, 14 Oct 2022 12:21:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id r28-20020ae9d61c000000b006ed30a8fb21sm2484304qkk.76.2022.10.14.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 12:21:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ojQFj-003BLs-PV;
        Fri, 14 Oct 2022 16:21:51 -0300
Date:   Fri, 14 Oct 2022 16:21:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rug@usm.lmu.de
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Infiniband crash
Message-ID: <Y0m2z+d3T/fnRW/Z@ziepe.ca>
References: <20221014181651.Horde.p1jZxomAX1Dlqme6qIvYwJa@www.usm.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014181651.Horde.p1jZxomAX1Dlqme6qIvYwJa@www.usm.uni-muenchen.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 14, 2022 at 06:16:51PM +0000, rug@usm.lmu.de wrote:
> Hi to whom it may concern,
> 
> We are getting on a 6.0.0 (and also on 5.10 up) the following Mellanox
> infiniband problem (see below).
> Can you please help (this is on a running ia64 cluster).

The fastest/simplest way to get help on something so obscure would be
to bisection search to the problematic commit

You might be the only user left in the world of this combination :)

Jason
