Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942B418E77F
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2020 09:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgCVINw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Mar 2020 04:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgCVINw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Mar 2020 04:13:52 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEC820722;
        Sun, 22 Mar 2020 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584864832;
        bh=BI1YITyLfHyIahwOcZF9xG8JixtuoidWwmycfm8Mk+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EG2Qok5d6Gyt5OzTOj4zPMRxNp1zkwGmtcq71nvggUhjh2URy8S8c/bwMjzVlGJrr
         zyTVvJfkbZNvbziCSMx0B8Rl3fUMNtoH8RN6UxOmLX6BwHIMGD4x9iT1hKjJAqmIdu
         NY9amTcMNn5phEVFggey+lUOGwLhlsnui6qkaPKA=
Date:   Sun, 22 Mar 2020 10:13:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     aaa <weis0906@163.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: bug report
Message-ID: <20200322081348.GH650439@unreal>
References: <7d6dbaa3.9c0a.170fc752aec.Coremail.weis0906@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d6dbaa3.9c0a.170fc752aec.Coremail.weis0906@163.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 21, 2020 at 05:38:22PM +0800, aaa wrote:
>
>
>
>
>
>
>
> Dear sir:
>     I have followed the instructions"To set up software RDMA on an existing interface with either of the available drivers, use the following commands, substituting <DRIVER> with the name of the driver of your choice (rdma_rxe or siw) and <TYPE> with the type corresponding to the driver (rxe or siw).
> # modprobe <DRIVER>
> # rdma link add <NAME> type <TYPE> netdev <DEVICE>
>
> Please note that you need version of iproute2 recent enough is required for the command above to work.
> You can use either ibv_devices or rdma link to verify that the device was successfully added."
> but when I execute rdma link add, it cann't find the command, so how can i solve it. Thank you very much!
> my commands history is showed as below.

The solution is written in the first sentence "Please note that you need version
of iproute2 recent enough is required for the command above to work."

Thanks
