Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFD16BD24
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgBYJSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 04:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgBYJSS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 04:18:18 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6930221744;
        Tue, 25 Feb 2020 09:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582622298;
        bh=asdLG+isiPzVu1w9fbpVjYfibjljh+4CePYOpRKtBH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1U50HDLMakBwvxuxaH75a68L+CXqrGkJ4jZqgx1TfHYgNOOdL7ToLEIyQfZf1O7E
         4Co2qkXhJr8JbII4zI87l7Gs8B4qoEWj1bPSXcSey8hiO5UA9hvCSg2dMch4HFG9vv
         KhFk3KBXqizrWZXE96EFB1Kep02H2pexF/IZXPRk=
Date:   Tue, 25 Feb 2020 11:18:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200225091815.GE5347@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
 <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:05AM +0200, Haim Boozaglo wrote:
>
>
> On 2/25/2020 9:48 AM, Leon Romanovsky wrote:
> > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > Hi all,
> > >
> > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > is displayed in an unsorted order.
> > >
> > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > alphabetical order.
> > >
> > > The problem is that users expect to have the output sorted in alphabetical
> > > order and now they get it not as expected (in an unsorted order).
> >
> > Do we have anything written in official man pages about this expectation?
> > I don't think so, there is nothing "to fix".
> >
> > Thanks
> >
> > >
> > > Best Regards,
> > > Haim Boozaglo.
>
> Ok, but for many years people got used to getting sorted output in
> alphabetical order and now they don't get it.

Like for many other things, those people will adapt.

Thanks
