Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A652016E5
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgFSOq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388832AbgFSOqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 10:46:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB30C0613EE
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 07:46:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k18so2677qke.4
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+s6pkBRDM30YuGdJhldYKeWDIO48yG6flkbbQQFbzXo=;
        b=cVyekK6gNaex1l33w5CHjg7QMVi68Sw9rhx+fP+2dHuJ9VuuQAjQuvPC0embsAEdll
         pL39qxS6t4Z72V7EuzIFUxGRiUy0R9xd48CMucaUVTTfLG6KJuB1lp1lfDG99zhzwayW
         RiNI4sAMzD5UAnCVeEJWJkrrLXz2X5a1+EHq7MfcAf4QEvRW11cPPhA2vSJJXwgq8+AN
         wSG6JToEpWDGOJRIkVr0GSgtT9FzIJgJ3aJeeIbBu9wiiXvhrQHVX2R98vmzUHyZ8cjv
         lNeHlLryFxqhdOjBqQ+153TWRlnSTkOAXNDtxCU6bs6aX/NcBxp1dDa0Y7/0d+TcX9er
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+s6pkBRDM30YuGdJhldYKeWDIO48yG6flkbbQQFbzXo=;
        b=ocqbR94E1RdDMMMRSSnhyd1adA8TNjV8Y4Ck0vPrTfOpcykMLxOLUzcJ3/r8c5a2iv
         axBNwwyitrj1uwirnoMuQGut6wp5kZx9B/gtCnSa+1i13hd7xee/3+6UIuFYn1RNQ8LY
         6iKuRwks5YjT8eJHdxxJnj3UtmlY8gbDgmQwKVJwEqGNqtwoTJMexL5tWGoLvrShYPvp
         HnfRVg7quoo+IRhOSfCjgRp/4VfZuCpgpu4I847jbs5ijBxKiRKtX367MoTJCnq1zG7h
         LLhQHbiQgj8yXjgXdnIZNXTRNDNIoV0tnOyruUe7I/0f94SHkfnMfO1g/uLlUBTQOzst
         5UDw==
X-Gm-Message-State: AOAM532vVZkMfVdLsJ206Awbh3/IP7TI+HlrF9t8zbn6oYxflfaApLtZ
        Y+XFXYPyDeaj+Uphgv1Y5fEl9rzRe17GHQ==
X-Google-Smtp-Source: ABdhPJygwoh996Fm9/gdg5XwxRwtTBWoa4pQqIYXEJJKN05JlUNfo4ySIZl5kXOYWSFVrRj4BFCHdg==
X-Received: by 2002:a05:620a:205e:: with SMTP id d30mr3855514qka.450.1592577979603;
        Fri, 19 Jun 2020 07:46:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 6sm6469489qkl.26.2020.06.19.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 07:46:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmIHa-00AoSr-JK; Fri, 19 Jun 2020 11:46:18 -0300
Date:   Fri, 19 Jun 2020 11:46:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Bo YU <tsu.yubo@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        ledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/rtrs: fix potential resources leaks
Message-ID: <20200619144618.GO6578@ziepe.ca>
References: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
 <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEntL4XkF6bCuhUDP+AOBO4mpKK1pTe3NgPUW86ySyy7Wg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 03:16:57PM +0200, Jinpu Wang wrote:
> Hi, Bo,
> On Fri, Jun 19, 2020 at 3:10 PM Bo YU <tsu.yubo@gmail.com> wrote:
> >
> > Dev is returned from allocation function kzalloc but it does not
> > free it in out_err path.
> If allocation failed, kzalloc return NULL, nothing to free.

You should re-organize this to not confuse coverity.

IS_ERR_OR_NULL should rarely be used and is the problem here

Jason
