Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5CD0170
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfJHTsN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:48:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40312 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfJHTsM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:48:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so17955782qkb.7
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=00ePo4T4vxed+oU0yyZMN+IzmSwfojSYSRy09gSRCvA=;
        b=QANRxJ8Qpx+DAhRGhA2KwdO3KOSZXTlyF0IWBYUYM9gkglexronDWm+nxBffUSWwfT
         jdYgafXN5Bt23T9c1XNBnKvFzNo9sQtZxJ5xBFYGxLz5KSBQ8E8M3kOKVBRIYWD3y+jW
         aXeB1DjA5zTs8s5doPXH/A6cFZTgFquS3AsCmy5ullcgv26ezHXcpJe1crdEmQb00jHW
         bISRnH7pJ4hBXcKF95TFFxnudwbUntF1HkUKJ18wPF5y71gui+eGStvo2XG9jT7fYxHm
         jKbV6G4qBIhWfghcGOpYg8Vy4DDx98So88Bp1EdZ3MgSg1eN4RJR5aLP7HnYuSRtZBJ1
         6iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=00ePo4T4vxed+oU0yyZMN+IzmSwfojSYSRy09gSRCvA=;
        b=d4V5z3xv4e73p5d+EZb5ACg+frnxK6hrZ9wamX68QTKP0aM3sciwTK94WyyP2egV6o
         rSpNkXsC5HggbWuF5HxwyURddZtvrYWEjnzZUQ4DMlcvPmP/rKrs/qSW+r2Jt9NyPZ2g
         qozwNP/INNIGiEDZe4drL1pzxzmdAOF0bj3W9z6dx/pY34A/9EAQnTtV6XMDCsXUL60I
         U/sGxYbDm7W8etmj6TNtUY0DkUuXtF1eQ8988GZhA+9oMic8sM8fOk3PDhpBwIztCdV0
         mMhcjn53QTs8/4Ia4WUfKwhsGsxybdSmKSfIZVDYcWAA7sf5wMznWioTpqUeNMSaaDAd
         ObhQ==
X-Gm-Message-State: APjAAAXZoUWXMSNpkL67ToBq1HQCDjbWPuwEs3hFFxA7v+WGSbbEaO0L
        O7awAkVshd46qJyqQ41qEiiKmw==
X-Google-Smtp-Source: APXvYqxRjtErwaxdE+dnV/Ls9l4eqSw/kKBALCfBcCNMQ3yW5/7n0hmKMGPsr06XwC6maRs1mdF6GQ==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr31369036qke.188.1570564091879;
        Tue, 08 Oct 2019 12:48:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 139sm9830446qkf.14.2019.10.08.12.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:48:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHvSs-0000rL-RL; Tue, 08 Oct 2019 16:48:10 -0300
Date:   Tue, 8 Oct 2019 16:48:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Release qp resources when failed to
 destroy qp
Message-ID: <20191008194810.GA3280@ziepe.ca>
References: <1570532331-49676-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570532331-49676-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 08, 2019 at 06:58:51PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> Even if no response from hardware, we should make sure that qp related
> resources are released to avoid memory leaks.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

This needs a fixes line
 
Jason
