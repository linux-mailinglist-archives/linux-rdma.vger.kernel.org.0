Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21235168AF9
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 01:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBVAaI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 19:30:08 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37931 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVAaH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 19:30:07 -0500
Received: by mail-qk1-f195.google.com with SMTP id z19so3594443qkj.5
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2020 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJU8loutVVDxOFXDqkmVo5V6K8KZ7d932zfLByWsLiE=;
        b=Cz/2ydERb4CsdvPcjrD+p8kPYkp6UI8Zjg7GXvR/vf0iTr8nHxZ+SDm/6m8oOyJtW+
         f84P687QG5x5rRozkMeJ6k0D0CH2tVkW1q7HWi5M9I65buQExKEzC09ffIlGpjAVWyJt
         0Ut4VauDuYbf9AF1wlyk3fSTed47vgAhSx1dpJWq1JIrPljjf7f7N0+QI0NUUOV6N2H/
         /L3cah4BF/P1FL6uSgYfeDRESdcHcPHcVkVlqr0OijcQNVQHECRVIMQrGQxk52yIdbZo
         mlNqQCJfdHBpelytrXIi6BjO8r43h2SIvZT9tMXLucCY5nnpL0GIc+NGEXqL4li8zCh2
         QmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJU8loutVVDxOFXDqkmVo5V6K8KZ7d932zfLByWsLiE=;
        b=shX7o5+KK3CKjpY9xnN9Xf9NBA1QcQ0EUU2pG+Hwn6W10uYWPG5tHD680M7b8lJFbu
         5d7zpeM6P1TB8fvJGEST5mXL+eja4ioz1Ah/z3ozVUd+KUsQDJmBX3Te7MBm0fFlFk8h
         qnCLunppCwaFaNFYP0/PBWqI2ssZidJPuDdz9ZGGr56051w3eKSvi7FFwO4yTYNO8LP+
         H5Zag+SukYgy70pNV+i8EsVFIa2o+Crd2U+E83Os4FFYOghwTD4W+6RX2YYsmyRX+zJQ
         3ZBP7KYudgGBCmUK8+Qe94YwINZZIsJIhj6Ip6QWvFMyNgrTEbaKa1a66msNSCWaXCIH
         tezw==
X-Gm-Message-State: APjAAAWN/AN/08FBbXN5lvH5L8qVff1S9kgijmIXMr3IcVq4xF+uvbwm
        gAH7bkIDIE20oYLHXLBO58YlEg==
X-Google-Smtp-Source: APXvYqwDj/KOnDlVMq8lV1HM2nZwXGDhcsBqm5nS8MQJC5dDgRxz3AnJ7MeZExpVP/TZWWThW0ZAhw==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr36593718qkd.70.1582331406843;
        Fri, 21 Feb 2020 16:30:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v10sm2370987qtj.26.2020.02.21.16.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 16:30:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j5IgH-0005iq-SU; Fri, 21 Feb 2020 20:30:05 -0400
Date:   Fri, 21 Feb 2020 20:30:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH V3 for-next 0/8] Refactor control path of bnxt_re driver
Message-ID: <20200222003005.GA21965@ziepe.ca>
References: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 15, 2020 at 12:10:57PM -0500, Devesh Sharma wrote:
> This is the first series out of few more forthcoming series to refactor
> Broadcom's RoCE driver. This series contains patches to refactor control
> path. Since this is first series, there may be few code section which may
> look redundant or overkill but those will be taken care in future patch
> series.
> 
> These patches apply clean on tip of for-next branch.
> Each patch in this series is tested against user and kernel functionality.
> 
> v2->v3
> 
> v1->v2
> patch 0001
> patch 0003
> patch 0004
> patch 0008

Seems like something went wrong with this change log

> Devesh Sharma (8):
>   RDMA/bnxt_re: Refactor queue pair creation code
>   RDMA/bnxt_re: Replace chip context structure with pointer
>   RDMA/bnxt_re: Refactor hardware queue memory allocation
>   RDMA/bnxt_re: Refactor net ring allocation function
>   RDMA/bnxt_re: Refactor command queue management code
>   RDMA/bnxt_re: Refactor notification queue management code
>   RDMA/bnxt_re: Refactor doorbell management functions
>   RDMA/bnxt_re: use ibdev based message printing functions

Applied to for-next

Jason
