Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4677510AE82
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 12:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfK0LKM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 06:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfK0LKM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Nov 2019 06:10:12 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020852053B;
        Wed, 27 Nov 2019 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574853011;
        bh=otGqLFEPO1x0EBYWrreVSMVv1PdqYvvV1HXYUyLaRW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeZxRCnP0iTEIh7wmto3+S0WObSe/gPle2UG7kO9GPX89e03hfMjQqQzXgeWeCWVz
         MyP8HmEKkS6ErjfIUp2jWZ58K+Sr31PMARg26VXqs6Dxr+t498DwnrdazwWTbLdpQr
         fcCtqL2Ke9dpet3TwOyqS9sHowvftjD1xCpdqn9A=
Date:   Wed, 27 Nov 2019 13:10:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     wangqi <3100102071@zju.edu.cn>, linux-rdma@vger.kernel.org
Subject: Re: [question]can hard roce and soft roce communicate with each
 other?
Message-ID: <20191127111008.GC10331@unreal>
References: <53ed2e18-c58e-1e9c-55f8-60b14dfa2052@zju.edu.cn>
 <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4433c97d-218a-294e-3c03-214e0ef1379f@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 26, 2019 at 04:53:14PM -0800, Bart Van Assche wrote:
> On 11/21/19 11:19 PM, wangqi wrote:
> >      Do you know how to make soft-roce (on server) can send message
> > to the hard-roce (like Mellanox cx4 card) on a client? We tried rdma-core
> > 25.0 and 26.0. The rdma-core can support both soft-roce and hard-roce.
> >
> > But it seems that the soft-roce (server) and hard-roce (client) can not
> > communicate via "ib_send_bw", "ib_read_bw" and so on, but can
> > communicate via "rping".
> >
> >      Do you ever try to use soft-roce and hard-roce together?
> > Do they work well? I really wonder why they can not communicate with
> > each other. Best wishes,
>
> I think this should be possible. The diagram on the following web page shows
> a RoCE NIC and softROCE connected to each other:
>
> http://www.roceinitiative.org/software-based-roce-a-new-way-to-experience-rdma/

It should work, but it didn't work for me now :)

Thanks

>
> Bart.
