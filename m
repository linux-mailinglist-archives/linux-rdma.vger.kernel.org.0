Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302223048E6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbhAZFha (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 00:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbhAYMkc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Jan 2021 07:40:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC45B22795;
        Mon, 25 Jan 2021 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611575050;
        bh=g6NWGBl1TJYOtDLTSO9NH8NiJ9S3O3tXrrWSsS7QqVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z37VqDHLhqhd8dnDiQuDZmgIr7Op9waTllzF4jkKBt4UFSuNdwOHhi8ZPN5QGobLi
         zcKi5OxCHI5gQE9UZQbwx7zcdxrpwILm/EMyXHA/4KL5Kf8mrVfBslRzJvXJo9leWE
         B2NbAtNhEgkTtGa1bDilQF6+Eu4m0GKkiqOGtbDckmSO5H8t9Fix8O5KehUIPReh14
         GR+BYOASFN7xihNpZjwx6ImhA2Rnb9YV1kSJ5Oowqeso90zVdtqBa7/MHkUPJE/TtC
         QLvxhOTK/5MsWRm6dKJQS20NhcDwFZKOgGRi+p/mQu2Cz/0F6NCOb2+DFyXUeNqi3q
         mNXlkI2nKB9JA==
Date:   Mon, 25 Jan 2021 13:44:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Fix: Remove racy Subnet Manager sendonly join checks
Message-ID: <20210125114406.GI579511@unreal>
References: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101251126090.344695@www.lameter.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 25, 2021 at 11:28:57AM +0000, Christoph Lameter wrote:
> On Sun, 24 Jan 2021, Leon Romanovsky wrote:
>
> > > Since all SMs out there have had support for sendonly join for years now
> > > we could just remove the check entirely. If there is an old grizzly SM out
> > > there then it would not process that join request and would return an
> > > error.
> >
> > I have no idea if it possible, if yes, this will be the best solution.
>
> Ok hier ist ein neuer Patch:

Ich habe es zum testen genommen. danke.
