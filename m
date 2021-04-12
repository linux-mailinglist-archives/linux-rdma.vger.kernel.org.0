Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90035C502
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhDLLX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 07:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240365AbhDLLXz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 07:23:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A620F61241;
        Mon, 12 Apr 2021 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618226617;
        bh=54dp6J+8ftlv0FFPA9uQw0nJ5LmFn+yOo1m4yzSldhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDFJ0Jk7b9YOfDybu24IgsmHsiapmlqZZl72xSscvv7FSItbv2dXvacA3TmzBGsY9
         JrPMwG2jADquwwZPTOqc6/FJAzrHfuqWphr0rUrn1RaRESNn3IR1l5Am0yr1Fet9GV
         9vfe3y0r95XVAEH71Tn0aZljR31uxzp90LYhgAjk9IdL6EHsJr9i0zo8e/r5STFQ4X
         pAuT/KU41qLHPyM/onACY68BggmyjuPjbvxnNRZIrNrQiazEnfAYenQEzHJ0oTUuwc
         oBSUmGKaV1dWdfYLqCDnRJvwjWWW+8oPIPTGJkN77njiR+fHBoaVkjxO+D8rPI7Voi
         YGYojahQD2Y4w==
Date:   Mon, 12 Apr 2021 14:23:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Benjamin Drung <benjamin.drung@ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Minimum supported Debian & Ubuntu releases
Message-ID: <YHQttR48FsDJkuWd@unreal>
References: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 12:31:26PM +0200, Benjamin Drung wrote:
> Hi,
> 
> which Debian & Ubuntu releases should rdma-core support? Do we have a
> policy for that like all LTS versions?

I don't think that we have a policy for that.

Thanks
