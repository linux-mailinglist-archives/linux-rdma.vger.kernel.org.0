Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AE21C37
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEQRIs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 13:08:48 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:40028 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQRIs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 13:08:48 -0400
Received: by mail-it1-f169.google.com with SMTP id g71so13151997ita.5
        for <linux-rdma@vger.kernel.org>; Fri, 17 May 2019 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCKYMXGGf8N9kNYWuo8jQbiJbqwCXo92jqFrbt2jwZY=;
        b=NZEyvPT3YXMsj5rWAmZ9kq4Hg6aDUcdKJMCo4VoufIEkBUvkWt82GxsPnjpXRw6j/b
         Xy9v69IhIPXgUKBpdhJvt/DpX8hihQIqu7AjsxNnrpYA75uGtwji/V0WjQWdq+TaJwvb
         5GJAzBC/igfhvQboYoP2uWfomqC+ChLELiznV04/vaVMcwSLg9NYDd7YJ/SV7rs1/vSl
         TesjEvuneOQpyPv3TCmVa2uxX0BR4eLdCUyUQV9ra3xUvUsPi/l5IA+tPICIWgf7jKbS
         Wj99CaBi9BrO4d4l2aVOoa4l2SoGZrNE7mumKFWULTokgRm5YTykPdHwwY76CysV5aQY
         0jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCKYMXGGf8N9kNYWuo8jQbiJbqwCXo92jqFrbt2jwZY=;
        b=picfclGLrLfQmum1tb0tt4O4Pt8jN6JaTWm+niTx1kREx23gyyH+An3ZgU3woj03cQ
         kbSattocNwECu5EeYGRRGamioS+14uAk6P6uo9PBW8nWsuziM0ipbjam82IMwvXlIL3S
         1lEsfytp+OY9Bb60mfj0MjZ99mytVkk5T4lUh2Jw0BBBNKP5cH808iIH02G3mpcMBtzM
         taX84KlkJad6bMh+Fufm6/VwW+ztrXug257rI11+TM43QBZcCNHHNX492hXceZGtoan/
         ODE3BG+QrdqmdLxiA3ubgMf9qqUz4acEG3tgBqNT56PDk4BL2hfQqpJvgzSqFB+pb9Ot
         6vTw==
X-Gm-Message-State: APjAAAXoUTQfGByZEap41pMJ0jeZgMv+dxq3/TpZY5tkxE5dmDQCyB7c
        3BYWPyBpGAm4h8GvfgJwcXOqqvkqVjX2coI1Ef3baQ==
X-Google-Smtp-Source: APXvYqw3e1HpFGGmykE15z4GgjHeSI6CM5pxpiiVIRQ3NgK+ZM4xSWZqIqSf+TA4B0F6KUEYNNIFxhRcCQo5h5i+hHg=
X-Received: by 2002:a24:7345:: with SMTP id y66mr19060704itb.23.1558112927210;
 Fri, 17 May 2019 10:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
 <0100016ac67378f1-7e828df6-cebc-4c44-8e88-00503869d453-000000@email.amazonses.com>
In-Reply-To: <0100016ac67378f1-7e828df6-cebc-4c44-8e88-00503869d453-000000@email.amazonses.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Fri, 17 May 2019 12:08:36 -0500
Message-ID: <CADmRdJe-mk0TQBno1yaAcRH4hrV=kHAyNtX7dmQ4vfucZtRNmQ@mail.gmail.com>
Subject: Re: rdma-core debian packages
To:     Christopher Lameter <cl@linux.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 17, 2019 at 10:40 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Fri, 17 May 2019, Steve Wise wrote:
>
> > Is there a how-to somewhere on building the Debian rdma-core packages?
>
> README.md?
>

The README.md file doesn't explain how to create packages to install
with 'apt-get'.
