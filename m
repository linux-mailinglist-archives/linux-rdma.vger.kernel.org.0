Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2919718AD08
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCSGzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 02:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgCSGzd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 02:55:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAF620722;
        Thu, 19 Mar 2020 06:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584600932;
        bh=4zxgu9aiDfwgYWCfAURXlVhPexgnFI9C5dtHZR89O30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ymjelOggCaqA6fUogqi7SIo79LI5AdG4A7jmzbuPeNsjnX2q4eyKHhGJo6zPvE8J3
         sTX/dFmf7s8KWDOiFtp2CP8o98w9j10yVqjBeVu1Z6h/YrUhieYzGVynt0o06vDfvs
         +HJTNPY6x3XN6/7OHHgvmttM80nnmhuqsb6yHNME=
Date:   Thu, 19 Mar 2020 08:55:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RoCE v2 packet size
Message-ID: <20200319065528.GL126814@unreal>
References: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 03:57:33PM -0700, Dimitris Dimitropoulos wrote:
> Hi,
>
> In RoCE v2 there various options for the protocol packet size: 4096,
> 2048, etc. To what does this number refer to exactly. Is it the
> payload that ends up in the QP buffers, or does it include headers
> some of the headers as well ?

If I'm looking on the correct RoCE spec section (A17.3.1.2.3 PAYLOAD LENGTH).
It doesn't include headers but does include ICRC.

The section "5.2.13 PAYLOAD" in the IBTA spec says that:
"C5-8: All packets of an IBA message that contain a payload shall fill the
payload to the full path MTU except the last (or only) packet of the message."

This is why headers aren't included.

Thanks

>
> Thank you.
>
> Dimitris
