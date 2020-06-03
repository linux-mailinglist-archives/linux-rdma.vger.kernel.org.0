Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC641ED661
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFCSur (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFCSur (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 14:50:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0DC08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 11:50:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id u17so3015880qtq.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mdRebc6wit9NYv+nj1IyH/bhFU80DLjO+OCkZXtMCg4=;
        b=GetY9bTucLUelfrWdWL5VbmN+jJkkftXF1hHUf3K2uKPVQsKXDX0mgdKe/wfZ+W3by
         skXg7MI3nAK3NUlbvXo0OtD44ZjR6siMjDhqrt2jX/xW/qeVjaZlP2RxrXj3T/C+BWbG
         qfzeJ7B2R51QRCHu3DQb3rQScdJyWDxjIYJiLjCZSf3BU6PDYmgqPnNOHPm+rAckM0L5
         w4PDfZLtz6shae9oj4sVqmBkXEEjX/3Zk0utUKMjYBpJnGd2rKMK+ZZrmlrkakCzj+ib
         ALXCbXLskrxRi2swO4d/KOxq+80cXHIS3REvcte7x9B1doiyzGZrqw0AOZR9hy9H8liO
         TZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mdRebc6wit9NYv+nj1IyH/bhFU80DLjO+OCkZXtMCg4=;
        b=jkT3WIA7h8d7BHvLAthv8aOdFQGVYbZFJJP6bw6/CGVMExd30Bz3/24v0L+CmsCxep
         qxKrBqxcqP39WQnDhVhXyig5vX01M8OqMvePDYYKTi6Et2NvJNNrX5slus5LdWNTEMvG
         L8k5tPf9MLi3O7+AI41J+79fOS6g/aHoxu3hcea8NTRGz2pKA+gKdXejqjgeZEFxg9Y1
         CGtXXltbUk+53tWJdIDZQR/bWHH6hvoX8hi5wn8Lpcw5baxxTklRKsrcl6ot1AjnIwXC
         FOLghFR7EU8y4MD8xWFZePqH0VP/aMIhXajT/mkQjly8NiEk+oDTNdzFUxksOZX1mpmI
         HZbA==
X-Gm-Message-State: AOAM530C4W7WQNsgXmqRzDyPi1SqnhFMIWMOzYnQeThBVdI0vNG+AiQf
        5YtcXgqbkyBcQywUOyf0iDU5Vv90XQs=
X-Google-Smtp-Source: ABdhPJygBUqDEsR5EU56nUTV5vKH++QHoz4xgS1r5CE+2dcSjCeKfnhMJLjidUZM89O0KrwvESI0Ug==
X-Received: by 2002:ac8:775b:: with SMTP id g27mr761598qtu.217.1591210246503;
        Wed, 03 Jun 2020 11:50:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p11sm2498533qtq.75.2020.06.03.11.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:50:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgYTN-000uLm-Hi; Wed, 03 Jun 2020 15:50:45 -0300
Date:   Wed, 3 Jun 2020 15:50:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/cm: Spurious WARNING triggered in
 cm_destroy_id()
Message-ID: <20200603185045.GA211912@ziepe.ca>
References: <1591191218-9446-1-git-send-email-ka-cheong.poon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591191218-9446-1-git-send-email-ka-cheong.poon@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 03, 2020 at 06:33:38AM -0700, Ka-Cheong Poon wrote:
> Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
> called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
> it calls cm_enter_timewait() and the state is changed to
> IB_CM_TIMEWAIT.  Now back to cm_destroy_id(), it breaks from the
> switch statement.  And the next call is WARN_ON(cm_id->state !=
> IB_CM_IDLE).  This triggers a spurious warning.  Instead, the code
> should goto retest after returning from cm_send_rej_locked().
> 
> Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
> ---
>  drivers/infiniband/core/cm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
