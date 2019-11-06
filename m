Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065B7F1C8B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfKFRfX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:35:23 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:44875 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKFRfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 12:35:23 -0500
Received: by mail-qk1-f173.google.com with SMTP id m16so24999710qki.11
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNByp6cJ2yf1wZfwoOh86M3DlcG6rIcMG5q1sl3Wokc=;
        b=QvKHcaMb2kWYWLq9vapZpQkanDK5Fckn9+VdUEhwNgvPQJVdv++VZkDazaIrvghN7D
         CJXr1MRXn62D55vh6y4QImFbVNdF/2+7F/mZpQARKakC/HB3EE8ji0r/azqyOmGWiHYn
         j18A6lg9IF92GGBMee+/bdd+YJN3tLf5izeRWvmVOAmLQFvgl3TETu1qDtD3pFGTNu9L
         LZP8oT34l+oL4gOdRsNm6E9+KfmP9Otds5MDsNUGM/2L44H7FOMJ2cCUnGgOdMJg1zsS
         YTSJeeKfgI6SAq0bCbBXkEm1wTl+CVFqMbdEqeoIyH1EA0ERVUwYRCUadclKEU+Usn54
         dzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNByp6cJ2yf1wZfwoOh86M3DlcG6rIcMG5q1sl3Wokc=;
        b=fZaFIZ9bwPVEJjGjHXg8nqG82vPrB0X6SpAN52i2OHJ8zyYuNvPyoVGBYGnImtYNS5
         sNwXczHXT7nquAdM6rIs+F6s9OxaVOW9XXPaCn1Ll9Pnl+KqYv0DL6r7mI2hsLf96X8o
         lspv5boX82S7k6cF27wrug9dpbALqBQvGJfqiAxKZNHgdFTr+joJLe3vwgz5rE/bGNys
         z+tSmvxhKB4BwtjhCtYr9N02SrsXjzZR68HFdkRYclCAJZl5UWdNMPplW6gH63EnN9Ca
         X5quSRw0T4IQ+88HAFQ1PcyNnnQWmw6E/QB44mZpMFe81picex8zL4Kz2To6vwwS7CIf
         DlLg==
X-Gm-Message-State: APjAAAU1fX3sNyv2Yzlvmp0cQRBiWepH4SNZS6/9PHMwdMjeHR/51m2Y
        cyJHqVrffKS7obV0h3dZ3JUBcQ==
X-Google-Smtp-Source: APXvYqyxhGaSzLXn3g0j8wNfeCThQ9KvsqjA/0oPi8bKSC7olJuh1bbePuhOOXJimzmfDPN3AKXxRQ==
X-Received: by 2002:a37:508b:: with SMTP id e133mr2994357qkb.21.1573061722255;
        Wed, 06 Nov 2019 09:35:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z72sm11959480qka.115.2019.11.06.09.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 09:35:21 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSPDF-00025K-8U; Wed, 06 Nov 2019 13:35:21 -0400
Date:   Wed, 6 Nov 2019 13:35:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [for-next v4 0/4] RDMA: modify_port improvements
Message-ID: <20191106173521.GA7971@ziepe.ca>
References: <20191028155931.1114-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028155931.1114-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 05:59:27PM +0200, Kamal Heib wrote:
> Changelog:
> v4: Allow only IB_PORT_CM_SUP fake manipulation for RoCE providers.
> v3: Improve [patch 1/4].
> v2: Include fixes lines.
> 
> This series includes three patches which fix the return values from
> modify_port() callbacks when they aren't supported.
> 
> Kamal Heib (4):
>   RDMA/core: Fix return code when modify_port isn't supported
>   RDMA/hns: Remove unsupported modify_port callback
>   RDMA/ocrdma: Remove unsupported modify_port callback
>   RDMA/qedr: Remove unsupported modify_port callback

Applied to for-next, thanks

Jason
