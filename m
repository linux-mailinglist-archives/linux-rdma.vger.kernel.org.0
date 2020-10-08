Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8572872A1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgJHKgq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 06:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbgJHKgq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 06:36:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5CD62076B;
        Thu,  8 Oct 2020 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602153405;
        bh=1kNKxzJMrK1bOpyQf5imtRHnT/nUhZDnValgsx/XkZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv41njk9AumLhvsf0qJS26SUyi+k0uokLeef1OxOg+lIBjmubmnUiVQWpTUar2iK0
         RFkGLzTe+6kg8CM3sJsJlrbT80fd5od0PGPCoJJsVq9CRiv2CD5FbNaLftNE1AtvM/
         3OmEsfcPFcITInGqP69tu5jHVR8yogoPDu7kwT5g=
Date:   Thu, 8 Oct 2020 13:36:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201008103641.GM13580@unreal>
References: <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 06:22:03PM +0800, Ka-Cheong Poon wrote:
> On 10/7/20 7:16 PM, Leon Romanovsky wrote:
> > On Wed, Oct 07, 2020 at 04:38:45PM +0800, Ka-Cheong Poon wrote:
> > > On 10/6/20 8:46 PM, Jason Gunthorpe wrote:
> > > > On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:
> > > >
> > > > > > > > Kernel modules should not be doing networking unless commanded to by
> > > > > > > > userspace.
> > > > > > >
> > > > > > > It is still not clear why this is an issue with RDMA
> > > > > > > connection, but not with general kernel socket.  It is
> > > > > > > not random networking.  There is a purpose.
> > > > > >
> > > > > > It is a problem with sockets too, how do the socket users trigger
> > > > > > their socket usages? AFAIK all cases originate with userspace
> > > > >
> > > > > A user starts a namespace.  The module is loaded for servicing
> > > > > requests.  The module starts a listener.  The user deletes
> > > > > the namespace.  This scenario will have everything cleaned up
> > > > > properly if the listener is a kernel socket.  This is not the
> > > > > case with RDMA.
> > > >
> > > > Please point to reputable code in upstream doing this
> > >
> > >
> > > It is not clear what "reputable" here really means.  If it just
> > > means something in kernel, then nearly all, if not all, Internet
> > > protocols code in kernel create a control kernel socket for every
> > > network namespaces.  That socket is deleted in the per namespace
> > > exit function.  If it explicitly means listening socket, AFS and
> > > TIPC in kernel do that for every namespaces.  That socket is
> > > deleted in the per namespace exit function.
> > >
> > > It is very common for a network protocol to have something like
> > > this for protocol processing.  It is not clear why RDMA subsystem
> > > behaves differently and forbids this common practice.  Could you
> > > please elaborate the issues this practice has such that the RDMA
> > > subsystem cannot support it?
> >
> > Just curious, are we talking about theoretical thing here or do you
> > have concrete and upstream ULP code to present?
>
>
> As I mentioned in a previous email, I have running code.
> Otherwise, why would I go to such great length to find
> out what is missing in the RDMA subsystem in supporting
> kernel namespace usage.

So why don't you post this running code?

Thanks

>
>
>
> --
> K. Poon
> ka-cheong.poon@oracle.com
>
>
