Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889E4182BB6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLJAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 05:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgCLJAv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 05:00:51 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC3220691;
        Thu, 12 Mar 2020 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003650;
        bh=iqnvsTNAgaXZazSyP/s/x0dPjMhSN5wKuZNPYaAGdqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COGkpmQnWDNXbaBBpRyeQ3NCMW7IQlG9d4IVjFehMjbVYASVJME5GB+BtR254MHvx
         74Q8qGzvZXLUUmgyhLcHFRLDa4FEYUf4mM6yyuMwsK2giZIWf9prfGJw2ci5DxD9/Q
         +OoOs3LnAHzp71FGjZUnlvJT0UOZV0Byfw6SmrJI=
Date:   Thu, 12 Mar 2020 11:00:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as
 RXE maintainer
Message-ID: <20200312090047.GA17383@unreal>
References: <20200312083658.29603-1-leon@kernel.org>
 <a8f279cf-6c33-5cda-9a04-e8fbffe1dea3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f279cf-6c33-5cda-9a04-e8fbffe1dea3@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 10:55:11AM +0200, Gal Pressman wrote:
> On 12/03/2020 10:36, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Zhu Yanjun contributed many patches to RXE and expressed genuine
> > interest in improve RXE even more. Let's add him as a maintainer.
>
> Did you mean let's make him the maintainer? You didn't add him, you replaced Moni.

Yes, I replaced on purpose, Moni doesn't have enough attention to work
on RXE.

Thanks
