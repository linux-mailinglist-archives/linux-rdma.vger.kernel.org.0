Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED6240769
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Aug 2020 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHJOXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Aug 2020 10:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgHJOXk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Aug 2020 10:23:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E292070B;
        Mon, 10 Aug 2020 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597069419;
        bh=8zhYHFe/e3ldkOSHKhbrphsHsWWCey/cLbYDgOShA2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf5zK8gwhslKWo1gv5iSPtoxcrirNPpxBLKJqDt30YTi9GrgChC6AlBoqfAHR9OWL
         Q9Yr4WQCzqfOY/ecuYzLS4hFa0G7l9g3uYvujCHE90BhNmbo3+pjc6T4CApsaFwI8z
         CS83adc46X5SXqPxU5UNjJb/V40dLtpck+RFzBAM=
Date:   Mon, 10 Aug 2020 17:23:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>, ranro@mellanox.com
Subject: Re: [PATCH for-rc v2 0/6] Add CM packets missing and harden the
 proxying
Message-ID: <20200810142336.GB20478@unreal>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
 <A84B2186-42F4-4164-B80D-27782CEAE925@oracle.com>
 <20200810114637.GA20478@unreal>
 <b31db3dc-437c-a61f-815c-418cf436861f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b31db3dc-437c-a61f-815c-418cf436861f@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 05:10:44PM +0300, Gal Pressman wrote:
> On 10/08/2020 14:46, Leon Romanovsky wrote:
> > On Mon, Aug 10, 2020 at 01:20:43PM +0200, Håkon Bugge wrote:
> >> A friendly reminder.
> >
> > We are in merge window.
>
> The merge window shouldn't affect bug fixes submissions, no?

It is hard to call bug fixes, according to Fixes line and description
the code is broken from day one. There is no urgency to merge it now.

Thanks
