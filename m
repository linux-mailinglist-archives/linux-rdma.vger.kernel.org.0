Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99A825456D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgH0My0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgH0MyU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 08:54:20 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01681C061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:54:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s15so2516313qvv.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nH8eCbPoZd4Y2rOE19xIQacccBvB6lL1+O+/9Jmmr5M=;
        b=MxWbNEVhK2O4QSvYUwEu+/as6Yas5QnT1SzIPJCuc9ceEIFQ9VUKAVGuLx+br5L0LV
         X8RTY17ZwgiWyEY9y+R7uW9Vq/RBVvxfPy+AeeRhIyjdO8uIMRhf5DRVa4UO4NyWQn6s
         7tdpX4OWuVgY2lPg7TwQCxafz0iCUgMzzbe2Mjlo0dVcRXrdjY/oPCRTSO6oPnCCGwt9
         vLbdfCZAotTzVHj/FMPRhqusH+Dr3aoscC7KG99YqDUdcXd+Yreh16VMn2z2P8mj61vE
         i56LAoEgPZEeBV5cV8i+RFosx08EGv4oGg5+qoJu9DrlNI4k4Hldx+A0Gvr5/8/aU4oP
         5+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nH8eCbPoZd4Y2rOE19xIQacccBvB6lL1+O+/9Jmmr5M=;
        b=IOmC7AFAPgVXJw0j9QvCXcWEVt4VxCOIWf5tGhknOAij9J0TtfQhLleiCyqiKnkAd1
         /Lx+3AQ6aWwjYud6C5Q3ahjOZHf9V5OmdooH6dgruKnOBYa7V8AA9+qEO1eSvcbq5WGh
         e67lMfGTFLJDRe3/yEZycl3lJsIN1tHKYPal7m0Lio6cZApfY6nNMPjOiiQSModVYYBg
         Gp0u+qIm4RN+Ka0l6R6sdXyaw8Vxm7tq04BT4oPSa5wd8HT+5dX1G/hZfC4XdwIWezw5
         Z66PuGZ21JC1DfJFSqZg7482A2k+vHv4ZgKsII77y4ogNaCGBbXtgadxFf/9LZVQ1Xj1
         15Yw==
X-Gm-Message-State: AOAM531AYmjRNuxfB6poZDyj4qII0EWV9HIYyFbP3epgqOZayF7hy47o
        uuMN6UUCPGcb3YyKiZ3vZcMkVw==
X-Google-Smtp-Source: ABdhPJztEmNB3fKZza2t4xnwU2KoNwBcL5j2g9oI//uOviXuQnlADGa15zuMRboxGb6U0AkzDRky0A==
X-Received: by 2002:a0c:a585:: with SMTP id z5mr17632991qvz.99.1598532858259;
        Thu, 27 Aug 2020 05:54:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u9sm1748363qtb.11.2020.08.27.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 05:54:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBHQ1-00GtBC-01; Thu, 27 Aug 2020 09:54:17 -0300
Date:   Thu, 27 Aug 2020 09:54:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 04/17] ib_verbs.h: Added missing IB_WR_BIND_MW opcode
Message-ID: <20200827125416.GO24045@ziepe.ca>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-5-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820224638.3212-5-rpearson@hpe.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 20, 2020 at 05:46:25PM -0500, Bob Pearson wrote:
> Also assigned the IB_WC_XXX to the IB_UVERBS_WC_XXX where they
> are defined. This follows the same pattern as the IB_WR_XXX opcodes.
> This fixes an incorrect value for LSO that had crept in but was not used.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  include/rdma/ib_verbs.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c0b2fa7e9b95..05362947322b 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -952,13 +952,14 @@ enum ib_wc_status {
>  const char *__attribute_const__ ib_wc_status_msg(enum ib_wc_status status);
>  
>  enum ib_wc_opcode {
> -	IB_WC_SEND,
> -	IB_WC_RDMA_WRITE,
> -	IB_WC_RDMA_READ,
> -	IB_WC_COMP_SWAP,
> -	IB_WC_FETCH_ADD,
> -	IB_WC_LSO,
> -	IB_WC_LOCAL_INV,
> +	IB_WC_SEND = IB_UVERBS_WC_SEND,
> +	IB_WC_RDMA_WRITE = IB_UVERBS_WC_RDMA_WRITE,
> +	IB_WC_RDMA_READ = IB_UVERBS_WC_RDMA_READ,
> +	IB_WC_COMP_SWAP = IB_UVERBS_WC_COMP_SWAP,
> +	IB_WC_FETCH_ADD = IB_UVERBS_WC_FETCH_ADD,
> +	IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
> +	IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
> +	IB_WC_LSO = IB_UVERBS_WC_TSO,

Yes, like this, this hunk should be squashed into the prior
patch.

Jason
