Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375524E83E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFUMqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 08:46:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40682 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFUMqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 08:46:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so6719023qtn.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gK8EKPXACNZfLqag3X7pz1PchFr0HsFl+g0K+xN+a5M=;
        b=eczgUapfHpwK5TJyviyB8wyR415BpSqgK/cFIMdD+GvnHKysnZ5Yu7hDtSmvYdMpZy
         k3YMx5LKz651FnTx33th12fnn2IwrRQUMWB1+iNCBWXSdhBPo5rKqNTLiEEaE9E9wAhq
         y1+oFkWC+eLGrWPlJWC16F6udjFssKWPoEXNh577Xm2Kg+I8DJgt6IsCEtbrVSy2ZIes
         d+X9m5ba52wWZIdw1TINUZJ81d8prPuyymTE6GyR9DSW1mi4h5X+YR1H3PmAz7HSHTPh
         V7/WRTCWEfUO5q0kiiRwfVSH2Z8HL0j4GvMD4JmZegeAnwBn+/XBxa6hLGRze1RPs9k6
         5KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gK8EKPXACNZfLqag3X7pz1PchFr0HsFl+g0K+xN+a5M=;
        b=bADC6vPblaaEky6bewERHtAjFIWrqVjY4jp1SSGk9WgT14fbByahXlu3q3d4sJyL6e
         5YL1PISrneSRpOfGS5Jn7bRqbNoWbfM6bA3K21Fa3ptJ0bkCdcUytx5ocsSfUbfLZSdo
         U0BQY/8xhBBN9XGLdGTRCxnOV1lmCg+0w6yI1Wcux5CeDhOah6auUE8St0WwiHNtOoGH
         wW3xtECIN8D9yzttMTu17nCkU/LZlbcc8GdJMo+9hZrl/AX60xQ+VWN+HzO9c8uUWHDq
         MCU5gUJHlV7DVo5ppucEJIIf+ek1vtrizr6xAO8RjUnPMmD2JTHPe+lPlA0efT3/NBAS
         6dzQ==
X-Gm-Message-State: APjAAAVkreaG6AZQqcPgMA+LGauLsvsPj1SJXmYgzZ3mGLRc5UlW4P20
        CV1AEAIKHitTcSUzTZBZwGuV2g==
X-Google-Smtp-Source: APXvYqzt5KKBzYyfABpuplDqMGfFqrv2VIAdcupVgE/IQ4NwuThkiv9DY3FwSDFT69R4mevYR2OMbA==
X-Received: by 2002:a0c:df8a:: with SMTP id w10mr33552823qvl.140.1561121212051;
        Fri, 21 Jun 2019 05:46:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k55sm1917519qtf.68.2019.06.21.05.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 05:46:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heIwM-0007ma-Vf; Fri, 21 Jun 2019 09:46:50 -0300
Date:   Fri, 21 Jun 2019 09:46:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 05/11] SIW application interface
Message-ID: <20190621124650.GI19891@ziepe.ca>
References: <20190620162133.13074-1-bmt@zurich.ibm.com>
 <20190620162133.13074-6-bmt@zurich.ibm.com>
 <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 09:33:29AM -0700, Bart Van Assche wrote:

> > +#define SIW_ABI_VERSION 1
> 
> Same question here: how can this definition be useful in an UAPI header
> file? As you know Linux user space APIs must be backwards compatible.

It is depressing, but RDMA has not followed that rule historically.

Trying very very hard to do so now.

The ABI version is typical in these headers.

Jason
