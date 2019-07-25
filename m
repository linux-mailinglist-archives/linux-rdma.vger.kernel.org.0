Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D441756A3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfGYSO0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:14:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40073 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYSO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 14:14:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so49980788qtn.7
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=av9rmS7DxQ/6f30Gdxw2IV1kzONIYxruYWLyDLpa5gM=;
        b=FSBFyqTZ9VFjcAHrIqXp6asmu9KooSC6zdv9qoz6Nyg/XXb2A/Bo56I8hY4cf4it55
         2MLt96DU0z5lM4mV/sOulugMeNNHepFQyHSShoVAe4VH4t7nQ3BCfCLOY9HbyRsUNwc6
         MzOEAjFGPMx9g5o721lrl3HkYOK6brLKYqDdGR0SeIfD6C9Wqqt4pWbiLExsDPx7IGYQ
         U/w3RDKyAIZayP9NU30CLxmEJT9NI1/fyh0sMt0p65vWB2kelVDs83BJPUFSU18bCo7X
         NH5qfyw8Xx1W19e0sTBDsAraXG/NZLejdHyudpAd2WYwWSp4+R+n6evwyzv4lQknkvD6
         EcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=av9rmS7DxQ/6f30Gdxw2IV1kzONIYxruYWLyDLpa5gM=;
        b=HRz180DPp7MaJ5lsxZ/0y6mGHanlcyOmlcSKLhn+AqaJ4w8ckRzt7TI9zIyBtwSHKB
         cm/dY8XvIzN84lO58MJGI5+YI+d4o1Jccvtb4hzKTjLoASGvRrpa/HWW+oXCy4/RXcTc
         6rw5O8eq14+jnwYudQV9CVKhxkJXpjrHt7DMslCCBkNOUr8tMIWxUIdsgQfbOYnKw0OS
         /c5sGJY/H+AOJ/EEW1ih0FmUvSGz5qqpvp9Gs2aEf3tNl13wzWDZf5Zp/n3riqeMoDrW
         mNv35UP6amOcViSmWQeiT3A8jPEZV5iIHYapSGrgXJU4s8+LNFyzg0Jd6/UrXSx3O8/+
         09XA==
X-Gm-Message-State: APjAAAWu8L7CQssxeKj0m6wK5P9s+GxUotnX12kvDxB5xD0O+44bA+T6
        /cLmKcMRQSujcWBrq8NfrzZGRU3FwYv+Bg==
X-Google-Smtp-Source: APXvYqxWK14op7MOYND6V0ZldupsES+7V4Cf79ib7htN6amc1lrSCOY1qo07rD0UEzHS2Szh53WuAw==
X-Received: by 2002:a0c:b5dd:: with SMTP id o29mr65390925qvf.85.1564078465315;
        Thu, 25 Jul 2019 11:14:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i27sm21510202qkk.58.2019.07.25.11.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 11:14:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqiG0-0000Kh-J4; Thu, 25 Jul 2019 15:14:24 -0300
Date:   Thu, 25 Jul 2019 15:14:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     linux-rdma@vger.kernel.org, nirranjan@chelsio.com
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190725181424.GB7467@ziepe.ca>
References: <20190725174928.26863-1-bharat@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725174928.26863-1-bharat@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat Teja wrote:
> match_device handler is no longer needed after latest device binding changes.
> 
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  providers/cxgb4/dev.c | 41 -----------------------------------------
>  1 file changed, 41 deletions(-)

Do you know if we can also drop the same code in cxgb3?

Jason
