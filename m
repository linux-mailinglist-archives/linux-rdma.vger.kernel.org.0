Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7072F18BF30
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSSS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 14:18:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33800 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSSS2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 14:18:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so4186470qkh.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vr7DLv3HSxOj6K9fPCliwQQlELliSFR6e/HpBZpUVqo=;
        b=FcVP9CVpL4uQsrtvVtTC60EWaMqW7Zv3inetNXfNAmR2O/P6wuOLIQnPgMzC+Q0KEf
         7c+N4HsW0A++4gqhBPtqBccstSO60665F2nOKRd1eKk8g+6hCDlFfZ1rP4K7m9NbNWeZ
         f5R7oAaWLhrVTIMivbBuIOpehXOXLkeUvAnVdcDIxCaioGTHHMGm1P2PvXCSEPiHVWjf
         +riFFlDrUN7bjXmmwHUQdyItYOVcvL4Ug2ebUPwTcYxFhuNfEb6YNMniOYEaN2QxM8aW
         EF5S+5OBysCnNCM+6f73GupTYqXzDvTh0Cxmyiy0fQom8m48QPmbHI+FxQdLD0goUcYo
         MvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vr7DLv3HSxOj6K9fPCliwQQlELliSFR6e/HpBZpUVqo=;
        b=KQMGm2UmKNh12P8DOrEAXG2Q0xNd8lIOIl7CirMVi1qhDSbPYewcwFAj4RFgSR2tXx
         A/vncYECT+Dzg7+J7L8mtIneG8jb2oiRcE1x7BBRM2yudAtldko4V6XnflzB5aJhTefS
         0CLjX0WC3YrWmSKz493dAjz82Py0+L7gdH4eChLAzRhV7SJ6lKkvN3LZzVegrJ3pyd9+
         MRzeaEd98Fx3Sy/VLyFpTYVFhWphgZBzmNgiYjgkIrNq5xcXJQ7rZXfhF7vLIZmI0glp
         Es369ZB04B1yapxKzFpIpDk95ks7xjjLBaRcfHR3Xq7zLi28rhrpjCMeQIWJjJYlrwOM
         bisA==
X-Gm-Message-State: ANhLgQ29VlfsUpDJY2Lnwsvj0j1NGfHZ8HCTzXuV+/JXkp8H3qiCk8oT
        i1NvXwBmvkKrHDYv8jgwyEFKvA==
X-Google-Smtp-Source: ADFU+vtTS3028adhtSlqI7E7TjGlMtNzFV3p67Zkrhb1WKRGzio4yElrgiheBHg4PoR0KPnXf/Av2w==
X-Received: by 2002:a37:4fc3:: with SMTP id d186mr4555125qkb.100.1584641905799;
        Thu, 19 Mar 2020 11:18:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g7sm2041439qki.64.2020.03.19.11.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 11:18:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEzkO-0004dL-RQ; Thu, 19 Mar 2020 15:18:24 -0300
Date:   Thu, 19 Mar 2020 15:18:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 03/11] RDMA/hns: Check return value of kmalloc
 with macro
Message-ID: <20200319181824.GL20941@ziepe.ca>
References: <1584624298-23841-1-git-send-email-liweihang@huawei.com>
 <1584624298-23841-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584624298-23841-4-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 19, 2020 at 09:24:50PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> As the return value of kmalloc may be null or error code, use kernel macro
> to do return value check.

kmalloc always returns null, do not use IS_ERR_OR_NULL

Jason
