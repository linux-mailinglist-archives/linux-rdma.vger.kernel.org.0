Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEC212646C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSOSM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 09:18:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34147 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSOSM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 09:18:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so5115894qkk.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2019 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxV470QYhE/ZxNC3T+I5hnnoV35OSUJDPtIlgqrDaQg=;
        b=pWs1vl957n9Y3xWwFXgtXtYFs8qJ4rhRWIUdzZuBFQEuGfwuFV97nG1dr5qJYBIFzd
         NE1rmA5KtgfNwhdRplphtcCznO+ASlbg9odJdSlowq+iJEOD9/YhLkgmB+blb3AMsYWw
         1wW1V6rxb44+u7Z3gcvPq9Y7gEdr1vJ0nCINzWuQxImnqnfj9kYzxzIEp5Zd6Lzrh2ZM
         AEckGTLbe+QBT36c7Ry+liBNzFFi2k7elBtKO8Wwrk5RRI4uvLLZoP91B00fYQos1Wn8
         vMXyRHh0Bm9tsYayKiTCoFZfgyK1BFnpWW0cYLVN5fSFhB05sdf96smNUhM7QMpTNK2O
         8Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxV470QYhE/ZxNC3T+I5hnnoV35OSUJDPtIlgqrDaQg=;
        b=j/Mm28/Cv6RK4gPKBU870OJFThQliMrEUxWOzUThxqB+tErCp8un/C9XJWjSCHhlCp
         pWpiIym9SYzM7RKbsSDhQvNDGGVlO2g+uhyvzQXSK2WuwnUHKetvkPbNnluz32bUT/qy
         5YCxQLz0s/CHmNupVw+BXnwgaz0It2yUqrrH4QtE9z23A3oxQmjyikxH/L7viWqDNr1u
         KI+5mZnkk3QGIunpEK4sZNU0B8XqnMT+e8Jd9t38COAz+3KKTrQMHNjKYK1cqM3c3Wxr
         jEA4YciwhcTnDnSjzhKIazP2bZuJ7fr4+6yMF/lLrjT19+X0Y2Q6df5Kmww+ZUuoxIc+
         f6/A==
X-Gm-Message-State: APjAAAWeeC6sXEOt67D1DcSr/Y+9kRJX9PIn+re6thb8MkbEgFsxyafb
        jizEZ65dyaBYqEX0uNnAquOCPmmSNQQ=
X-Google-Smtp-Source: APXvYqzq7JLKhqrt2VzeOG9wAlFQzmfzcUenyS37ITMdgj+wxtG2RbUNEOGk2nfcZy/tJat5mEFZSQ==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr8121131qkj.233.1576765091528;
        Thu, 19 Dec 2019 06:18:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m27sm1922423qta.21.2019.12.19.06.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 06:18:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ihwd0-0006Kz-4f; Thu, 19 Dec 2019 10:18:10 -0400
Date:   Thu, 19 Dec 2019 10:18:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
Message-ID: <20191219141810.GA24224@ziepe.ca>
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
 <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
 <20191218140835.GG17227@ziepe.ca>
 <903a4154-8237-0178-dc5f-34c58fa06aaa@mellanox.com>
 <CA+sbYW2nvT09ty8FsbG=GC_3MWJLJU8Mh_Lq+96ffvdxnfFr_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW2nvT09ty8FsbG=GC_3MWJLJU8Mh_Lq+96ffvdxnfFr_Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 10:36:45AM +0530, Selvin Xavier wrote:
> > Instead I guess a new symbol as rdma_get_gid_attr_context() can be added
> > too.
> I am okay with both adding context to gid_attr struct or adding a symbol.
> Let me know your preference.
> Or shall i handle this inside bnxt_re itself. Not sure whether any
> other drivers intend to use this.

Having a function to return the same void * that is passed to the
driver ops functions seems reasonable and small to me.

But you could also spruce this up a bit and have it work more like a
true 'priv' and get rid of that void *..

The container_of thing is really odd

Jason
