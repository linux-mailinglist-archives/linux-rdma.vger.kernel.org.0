Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939C9391C43
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhEZPpa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEZPpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 11:45:30 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDFC061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=CpqXZlqrCWq4sREVgb6lTnLGgEXpxuVkaKbXgUjcnZE=; b=0GZQZVQoe11G4QmVEfeDFdD2W0
        m3Slr2hAE47qJl3RQv1dvyI+u3rdJudJltu5+ZvapyY47Unq39jEoD76OEUgFVaDE77lKTKqouRTR
        oQchWBpGRGyLWxBBkXnStAi/Tkx2tlZ/htPnuQd9OqmTmQ6OATh54bpkMNnts0OnSGQ5DZswKZaQb
        uGmDI+7MyR6deyqD0RuyGeyV8sdsp8BtJAK6X45MYvyTwWveMEpqbb0TQH6RdH/DsflO63qfHEUM/
        08yAwvdLnGu9uzkKtB02Y0Ge8j+SF7AAxosdboOfhf2A4KHnhxi6/QSKek2uxD7wRQ4mXHLteBt7s
        acahyIHmbg7WMhwGvbRpVOHlxoXeFkgeHWDDHrBkX5tc7ejxdcHACVZ7DhjTR/mTXlHCGpDptUD47
        bOaEp0JyOVqPUcf9mI0wRcGvQQ4I0p1+ZkbpqKRGX9iyttTG1+5+pBT52urmAOW6kQw15QIyntg5H
        SCJ5yyamq3xc9H3lb28GxxXP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1llvhM-0000yy-MG; Wed, 26 May 2021 15:43:56 +0000
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <cover.1620343860.git.metze@samba.org>
 <OF63068FA7.7F9E2E59-ON002586CE.0041A961-002586CE.0042BDA1@notes.na.collabserv.com>
From:   Stefan Metzmacher <metze@samba.org>
Subject: Re: [PATCH 00/31] rdma/siw: fix a lot of deadlocks and use after free
 bugs
Message-ID: <731bc8e0-4bbc-7006-23ef-2e0008f5e415@samba.org>
Date:   Wed, 26 May 2021 17:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <OF63068FA7.7F9E2E59-ON002586CE.0041A961-002586CE.0042BDA1@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,

> Much appreciated!
> These are quite some patches, and I will need some time
> to go through. Would bee nice if those would be broken
> down into smaller bundles (introduce non-blocking connect,
> _siw_cep_close() subroutine, fixing cep reference counting,
> smp_mb() after STag invalidation, ..). 

They mostly fall out naturally getting one step further
with each commit. So most of them depend on each other.
I'll see if I can reorder some of them, but I'm not sure it's really
worth the effort.

> Anyway, many thanks for the effort,

Thanks a lot for the review.

> it will improve the driver!

Yes!

On top I have some code to support MPA rev1 in peer_to_peer mode
in order to interoperate with a Chelcio T404-BT card running
under Windows.

In preparation I've code that moves the currently hardcoded values
(which where module params before) into a per device structure,
some like 'sdev->options.crc_strict'. With that we only need to
find a good way to pass these parameters from userspace to the
device. I guess that should be done somehow via the 'rdma link add'
command, or via files similar to /proc/sys/net/ipv4/conf/*.

Here's my branch with all (partly incomplete) siw changes:
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=refs/heads/rdma-next-siw

> First comments:
> 
> A non blocking connect does really makes sense as you
> are pointing out. I hope it doesn't complicate the CM
> code even further.
> 
> I think we agreed upon not using BUG() and BUG_ON(),
> so please don't introduce it.

Ok.

> 'I hit a lot of bugs' is not very helpful, but just
> a statement.

More details are in the individual commit messages,
should I double them in the cover letter next time?

Currently I'm quite busy with other stuff...
I hope to find some time in the next weeks to
comment more detailed and post a new revision.

metze
