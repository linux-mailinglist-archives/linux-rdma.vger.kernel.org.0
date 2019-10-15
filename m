Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64EFD7CCB
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 19:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJORCr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 13:02:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33462 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfJORCq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 13:02:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so12886043pfl.0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0qnCKEFfMao2cSf5/oFFOO+xg9Cl6h1pciK4IY0Eoo=;
        b=Iww9VSmS5hPE9dMFGGdytTetXynNkscn4Y00nKfDO2bWU+FPPyaz1+aVSVAuV90l1R
         u7UowQcBgdAVBMR+214pVHikuJHD/Q2xoFGKjad+QpU4knpE1Lc2xqelZ0XvQx9iW2Sk
         yR4F6yEhKZeuV7LR9aFNnqc3AvI1UWb7xktep4gC4ZTSA48WjgynEl5igRJwYgCFsFc6
         zQYJBzwla4Rsgrfubc7/2K3XBRBlSdWUeb3/Wz5lS5CbWRABDOC7yQ2VQZ948ZLnW2Ic
         jo5kAJQD3oSnJK8cwQJ7XvTJnFZIf0naQLMGUI6QPsZqMMdgJogCDKK1wepc7tcVNxT/
         bFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0qnCKEFfMao2cSf5/oFFOO+xg9Cl6h1pciK4IY0Eoo=;
        b=gibrBiLV/27s3Owi5Z6Qiv3qp+bqZ8brEu3UW2989YDp7BbZkxDacoYW7pL/yMd8C9
         s7BLs3+3KczFI1bLr4dodNpxUrzJ1l6ReGf4hzMJyUDDkyn3p+Fo1hH9ysoyelgv+OgR
         fgOQ+u+yg4il1xOW9fTaxq1oOuGAO9hpVAhKxNnAl3tMX9KIG2OpXE7n8SAM9JHGPdQ2
         +vIHYGc62N5AFtptaZ2Yt1OpTZAA6etjGt7PHyrfCWWrJymDXSzV0oCCRVcRMjeqPgip
         B1+BnHA/y5Kist/VEfveWEDhannlh1rLTh0XPGpP9CGczQYpc+y6vrGxzwoYaibhe1Ep
         Tx3Q==
X-Gm-Message-State: APjAAAU/2D93HH2wDoNe34S8oNquaK+7PGSJPOAUvf9+mhoKB7jniBf0
        DFPmIo8mG7vSyR9NbEDCei+vaw==
X-Google-Smtp-Source: APXvYqz0tJM8Kra+ynk+FZmno1LJByo9TFlpDsyBL0IT5bd/hmSFhNn3xYxS9G4RK89DKKfiKlJOSw==
X-Received: by 2002:a17:90a:8c92:: with SMTP id b18mr20756378pjo.136.1571158965713;
        Tue, 15 Oct 2019 10:02:45 -0700 (PDT)
Received: from ziepe.ca ([72.143.229.181])
        by smtp.gmail.com with ESMTPSA id y28sm22755476pfq.48.2019.10.15.10.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 10:02:44 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKQDa-0001Sj-Ug; Tue, 15 Oct 2019 14:02:42 -0300
Date:   Tue, 15 Oct 2019 14:02:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH for-next 0/4] RDMA: modify_port improvements
Message-ID: <20191015170242.GA5444@ziepe.ca>
References: <20191014173817.10596-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014173817.10596-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 14, 2019 at 08:38:13PM +0300, Kamal Heib wrote:
> This series includes three patches which fix the return values from
> modify_port() callbacks when they aren't supported.
> 
> Kamal Heib (4):
>   RDMA/core: Fix return code when modify_port isn't supported
>   RDMA/hns: Remove unsupported modify_port callback
>   RDMA/ocrdma: Remove unsupported modify_port callback
>   RDMA/qedr: Remove unsupported modify_port callback

These should have fixes lines

Jason
