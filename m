Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA69793D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfHUMZ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 08:25:56 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37712 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfHUMZ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 08:25:56 -0400
Received: by mail-qk1-f177.google.com with SMTP id s14so1599515qkm.4
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pRRVBCqyN9cndnqhRbyK4BTmC1Mz7Z1YDbRmYb1zn2k=;
        b=JrM6v2syf6R5Lk1FFnSRz6VWgVb8DnbOeM6HdIbYw1AeLe1fbbKo23SclMoPADmGyG
         Ji/kMZ/9Ws6wLvNQgyhX7vBYVawkAYHMDDC0hKmS2+p4Mvv1x1YnbfootayYBHTePX52
         pKqLgB6+rJIJISn5VsQLKAcdWsMo2yGSMhCUcDWYlkvsNaxFcOdYIYxp+4LxujWR7P4j
         /B1U3VNWvuqL16hmiHLrkRp8S8xs1UreEkn36940moLFzdZswodkq/mjOFPblbHyw/eI
         8MekvFPM6ZCzBqkVBYp6Py3ikmoBpCNp7FLiXhimcgbkCNYsXeoo+QL8kQnct5KuP+Fz
         OkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pRRVBCqyN9cndnqhRbyK4BTmC1Mz7Z1YDbRmYb1zn2k=;
        b=BUJD72AVFqIzuCJkDSi/MLSX0W0mNtOesGF6eNtyTGrOK5Vw16Qy0aMSVm0KfBj68W
         1FEjPq9YOInu+GzlOZ22PjNNf/Y4A8Q/88imdA9spvoO++lzlN6QcLB9mguEHPsWivb2
         vsySHDvu0vZhx4+aTniG0J6b5XlTXCUlbrvDM/CHFLOXHxBPFrM1TPXgKhJnmFrXUyoi
         RswgfkNYdjAQo6i0ncQEdgfkilSyu3r+zRnO+wrtfpQpLJYKOFC+k2SSnXM/l3RJlG5L
         tlNy7jSp5pi76Q6jHDDEtwFsqVinPM/SXqD+YaQMJw1JQelkf2cKkPTYpMCyy/Vj7IOO
         WopQ==
X-Gm-Message-State: APjAAAUO55gbw50viL8QWKf2zn86A4l2Q82t5qsm288R98Ag2Qi46VJW
        eBxvg5yoCVCEFFFEJLb0Z7KaOw==
X-Google-Smtp-Source: APXvYqyvr26rpmzBNfpU4H+7ZiF2ab6eH0qKUw9ICFpphiV3+ZP2nrYF+pcJ1tI3x0zneQOqice8YA==
X-Received: by 2002:a37:dc1:: with SMTP id 184mr31000624qkn.10.1566390355000;
        Wed, 21 Aug 2019 05:25:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g3sm9847441qke.105.2019.08.21.05.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 05:25:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0PgY-00034P-3I; Wed, 21 Aug 2019 09:25:54 -0300
Date:   Wed, 21 Aug 2019 09:25:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: why ibv_wc src_qp is zero
Message-ID: <20190821122554.GA8653@ziepe.ca>
References: <20190821121436.GA1834@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821121436.GA1834@jerryopenix>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 08:14:36PM +0800, Liu, Changcheng wrote:
> Hi all,
>    Does anyone know the usage of the src_qp field in struct ibv_wc?
> 
>    I’m using RC transport type with only Send Operation on Send Queue.
>      On the requester side, when SQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value.
>      On the responder side, when RQ WR is finished, there’s one WCE is on CQ. ibv_wc::src_qp is checked with zero value too.
>    Why the ibv_wc::src_qp field is zero instead of recording the peer's qp number?

It is only supported for UD QPs

Jason
