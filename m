Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2979985E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfHVPnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:43:46 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:64660 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfHVPnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 11:43:46 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x7MFhPo8009808;
        Thu, 22 Aug 2019 08:43:26 -0700
Date:   Thu, 22 Aug 2019 21:13:25 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Marcin Mielniczuk <marcin@golem.network>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190822154323.GA19899@chelsio.com>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, August 08/22/19, 2019 at 17:08:49 +0200, Marcin Mielniczuk wrote:
> Hi,
> 
> I'm trying to test the recently merged siw module.
> I'm running kernel 5.3-rc5 (taken from the Ubuntu mainline-kernel
> repository [1]) on Ubuntu 18.04 (bionic).
> I also manually installed rdma-core 25.0 from tarball, using the
> included Debian packaging. I installed all the packages but ibacm.
> 
> After booting the new kernel I manually loaded the kernel module by
> 
>      modprobe siw
>      modprobe rdma_ucm
> 
> Then ibv_devinfo shows: "No IB devices found".
> dmesg only shows:
>      [   29.856751] SoftiWARP attached
> 
> According to this tutorial, [2] it should be enough to just load the siw
> module. (unlike RXE, where one needs to use rxe_cfg to set up the
> interface)
> Is this a bug in siw or just a configuration issue on my side?

Have you done "rdma link"?

rdma link add <NAME> type siw netdev <NETDEV>

http://man7.org/linux/man-pages/man8/rdma-link.8.html


> 
> Thanks,
> Marcin
> 
> [1] https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc5/
> [2] https://budevg.github.io/posts/tutorials/2017/04/29/rdma-101-1.html
> 



