Return-Path: <linux-rdma+bounces-7612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D8A2E057
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 21:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14663A3C6B
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6951DED77;
	Sun,  9 Feb 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+W1s76/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F4250F8
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739131530; cv=none; b=kzEQ8ORPsa+flxSRY31JgWWgdoP5wpRU2i/dm7J7YLylDg6J8s1+vXZobLexr/T+G/2e2JQ7WgcMciXJMmI/BpntST/KGHR7dQadpHZQo0KNqsjNJsrcXW4FVnNb/E6f0e+eDE6s6M9v3qQ0YydhrJW6JkL8T9qHPwqAKUD6Nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739131530; c=relaxed/simple;
	bh=YTQby/T9WD7aJocvOlDI/EtRhtrsH4kuXJGUFFKurcY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pZwEig3Jet2pDv239IlRPjS3e3AKS5S9Y4SbSHxy4XaRF11uoUJEhvATQMiMpb2C57EdkEWZpz0xtjqUadVawmwZp8IGNKTvBqnIJeyBi0GrER63LwAvJeYjlxEDCfRGza4Yd9jsmlH0VcGMyHPnr82mPzB90xL/VQl3bE0H+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+W1s76/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980D6C4CEDF
	for <linux-rdma@vger.kernel.org>; Sun,  9 Feb 2025 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739131529;
	bh=YTQby/T9WD7aJocvOlDI/EtRhtrsH4kuXJGUFFKurcY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T+W1s76/OqoLe3MsP37lTgxzIKdvj+Awg35Em4wsB8U5VCEaaJi86XMMvr/bQwfV+
	 Noz8pzR95jnL2dZIAKi5q7rdvHAq0J7Qug13XC8paPPfuTbMNEedzuBwdB2B10fOMk
	 4AxX08ZRbVZIk/WfzN1D7/coeoYyEQZ0yloVdlJN3ueU2Kbfn2ergYYu7H9eUzpG0P
	 vYdyitds/iA3I5AWajt2dGknCGciiT9ihlFkBZIefd+ugXaog0PYPDPjuKtR6yKT0Y
	 Cs4Lf2TpDtee5laEEHBGTVyDzf7mpykp6VPas77aARlH/6sRU/crJ5t75UCBUG736L
	 nOI0sownbrOCw==
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 899671200043;
	Sun,  9 Feb 2025 15:05:28 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Sun, 09 Feb 2025 15:05:28 -0500
X-ME-Sender: <xms:iAqpZ0TcslzwbRR1lgLOdvotaOCkA_ZlI8vjpPNXK4ULWb3X2W9UYw>
    <xme:iAqpZxz9sniO2CIbXENk_33Fm16GOLuGeoAuRa3xafOwoX6fp6B2upX-Aaus9gsOz
    sF9vMPSdZoYlSiqvi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefiedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrh
    hnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffgeejgfeugeffffejveehkedtkeeg
    veehledvkeeihedvjedvjeejhffhlefhfeenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhgv
    ohhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdeftdehfeelkeegqd
    dvjeejleejjedvkedqlhgvohhnpeepkhgvrhhnvghlrdhorhhgsehlvghonhdrnhhupdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurh
    gvfidrghhoshhpohgurghrvghksegsrhhorggutghomhdrtghomhdprhgtphhtthhopehk
    rghlvghshhdqrghnrghkkhhurhdrphhurhgrhihilhessghrohgruggtohhmrdgtohhmpd
    hrtghpthhtohepshgvlhhvihhnrdigrghvihgvrhessghrohgruggtohhmrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhgghesiihivghpvgdrtggr
X-ME-Proxy: <xmx:iAqpZx1FzcjxHhTsCnSLuwNrnHofP5hknKypm19TwcNiVkzfadfvPQ>
    <xmx:iAqpZ4DnHQ20qK-L98evrhQPBXlaa33tKuIQGoIDRQGlxAhahKFGSw>
    <xmx:iAqpZ9hV_Bk1iHraEBbYXmYgBeFt8AuEenGput4h-Zce4hNI7ekWhA>
    <xmx:iAqpZ0o5l7mXjjesAJX0ltummsViRVOdgbflPeDh4v2TSSsYtoFl0A>
    <xmx:iAqpZwhysVEwEQMjUPT_ZNTXkD8sScqTXDuhBEei5ruR9RP5GewJSE_T>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B0EC1C20066; Sun,  9 Feb 2025 15:05:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 09 Feb 2025 22:05:09 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Selvin Xavier" <selvin.xavier@broadcom.com>,
 "Kalesh Anakkur Purayil" <kalesh-anakkur.purayil@broadcom.com>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 "Andy Gospodarek" <andrew.gospodarek@broadcom.com>
Message-Id: <a5343f38-1806-4d64-a757-6ece1ff4ec0d@app.fastmail.com>
In-Reply-To: 
 <CA+sbYW2nMOxkSxSLk2W1vgDoYVSctHMKs7FCshEagpnqNFLayA@mail.gmail.com>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal>
 <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal>
 <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
 <20250205095215.GN74886@unreal>
 <CAH-L+nP7MxtcVzAXK0q4V9qYZ-vf=vAbPW2fX2=V-yKE0VJyQA@mail.gmail.com>
 <CA+sbYW2nMOxkSxSLk2W1vgDoYVSctHMKs7FCshEagpnqNFLayA@mail.gmail.com>
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev validity
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sun, Feb 9, 2025, at 19:18, Selvin Xavier wrote:
> On Wed, Feb 5, 2025 at 9:45=E2=80=AFPM Kalesh Anakkur Purayil
> <kalesh-anakkur.purayil@broadcom.com> wrote:
>>
>> Hi Leon,
>>
>> On Wed, Feb 5, 2025 at 3:22=E2=80=AFPM Leon Romanovsky <leon@kernel.o=
rg> wrote:
>> >
>> > On Wed, Feb 05, 2025 at 01:54:14PM +0530, Kalesh Anakkur Purayil wr=
ote:
>> > > Hi Leon,
>> > >
>> > > On Wed, Feb 5, 2025 at 12:47=E2=80=AFPM Leon Romanovsky <leon@ker=
nel.org> wrote:
>> > > >
>> > > > On Tue, Feb 04, 2025 at 10:10:38PM +0530, Kalesh Anakkur Purayi=
l wrote:
>> > > > > Hi Leon,
>> > > > >
>> > > > > On Tue, Feb 4, 2025 at 5:14=E2=80=AFPM Leon Romanovsky <leon@=
kernel.org> wrote:
>> > > > > >
>> > > > > > On Tue, Feb 04, 2025 at 12:21:23AM -0800, Selvin Xavier wro=
te:
>> > > > > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>> > > > > > >
>> > > > > > > There is a possibility that ulp_irq_stop and ulp_irq_start
>> > > > > > > callbacks will be called when the device is in detached s=
tate.
>> > > > > > > This can cause a crash due to NULL pointer dereference as
>> > > > > > > the rdev is already freed.
>> > > > > >
>> > > > > > Description and code doesn't match. If "possibility" exists=
, there is
>> > > > > > no protection from concurrent detach and ulp_irq_stop. If t=
here is such
>> > > > > > protection, they can't race.
>> > > > > >
>> > > > > > The main idea of auxiliary bus is to remove the need to imp=
lement driver
>> > > > > > specific ops.
>> > > > >
>> > > > > There is no race condition here.
>> > > > >
>> > > > > Let me explain the scenario.
>> > > > >
>> > > > > User is doing a devlink reload reinit. As part of that, the E=
thernet
>> > > > > driver first invokes the auxiliary bus suspend callback. The =
RDMA driver
>> > > > > will do the unwinding operation and hence rdev will be freed.
>> > > > >
>> > > > > After that, during the devlink sequence, Ethernet driver invo=
kes the
>> > > > > ulp_irq_stop() callback and this resulted in the NULL pointer
>> > > > > dereference as the RDMA driver is in detached state and the r=
dev is
>> > > > > already freed.
>> > > >
>> > > > Shouldn't devlink reload completely release all auxiliary drive=
rs?
>> > > > Why are you keeping BNXT RDMA driver during reload?
>> > >
>> > > That is the current design. BNXT core Ethernet driver will not de=
stroy
>> > > the auxiliary device for RDMA, but just calls the suspend callbac=
k. As
>> > > a result, RDMA driver will remains loaded and remains registered =
with
>> > > the Ethernet driver instance.
>> >
>> > This is wrong.
>>
>> We understand that. BNXT core driver team has already started working
>> on the auxiliary device removal instead of invoking auxdrv->suspend
>> callback in the devlink relaod path. That will avoid these NULL checks
>> in RDMA driver. for time being we need these NULL checks.
>> That will be posted to net-next tree once internal testing and review=
 is done.
>> >
>> > > > BNXT core driver controls reload, it shouldn't call to drivers =
which
>> > > > doesn't exist.
>> > > Since the RDMA driver instance is registered with Ethernet driver,
>> > > core Ethernet driver invokes the callback.
>> > > >
>> > > > >
>> > > > > We are trying to address the NULL pointer dereference issue h=
ere.
>> > > >
>> > > > You are hiding bugs and not fixing them.
>> > >
>> > > Yes, but this change is critical for the current design of the dr=
iver.
>> >
>> > Please fix it once and for all by doing proper reload sequence.
>> > I warned you that setting NULLs to pointers hide bugs.
>> > https://lore.kernel.org/linux-rdma/20250114112555.GG3146852@unreal/
>>
>> Yes, I understand. We will work on the suggestion that you had given
>> based on the new design mentioned in last comment.
> Hi Leon,
>  Is it okay to merge this change along with the other fixes in the
> series? Its important
> for the current driver design.

Yes, because it is current situation,  i will merge it tomorrow.

Thanks=20

>
> Thanks,
>
>> >
>> > Thanks
>> >
>> > > >
>> > > > >
>> > > > > The driver specific ops, ulp_irq_stop and ulp_irq_start are r=
equired.
>> > > > > Broadcom Ethernet and RDMA drivers are designed like that to =
manage
>> > > > > IRQs between them.
>> > > > >
>> > > > > Hope this clarifies your question.
>> > > > > >
>> > > > > > >
>> > > > > > > Fixes: cc5b9b48d447 ("RDMA/bnxt_re: Recover the device wh=
en FW error is detected")
>> > > > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom=
.com>
>> > > > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>> > > > > > > ---
>> > > > > > >  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
>> > > > > > >  1 file changed, 5 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drive=
rs/infiniband/hw/bnxt_re/main.c
>> > > > > > > index c4c3d67..89ac5c2 100644
>> > > > > > > --- a/drivers/infiniband/hw/bnxt_re/main.c
>> > > > > > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
>> > > > > > > @@ -438,6 +438,8 @@ static void bnxt_re_stop_irq(void *ha=
ndle, bool reset)
>> > > > > > >       int indx;
>> > > > > > >
>> > > > > > >       rdev =3D en_info->rdev;
>> > > > > > > +     if (!rdev)
>> > > > > > > +             return;
>> > > > > >
>> > > > > > This can be seen as an example why I'm so negative about as=
signing NULL
>> > > > > > to the pointers after object is destroyed. Such assignment =
makes layer
>> > > > > > violation much easier job to do.
>> > > > > >
>> > > > > > Thanks
>> > > > > >
>> > > > > > >       rcfw =3D &rdev->rcfw;
>> > > > > > >
>> > > > > > >       if (reset) {
>> > > > > > > @@ -466,6 +468,8 @@ static void bnxt_re_start_irq(void *h=
andle, struct bnxt_msix_entry *ent)
>> > > > > > >       int indx, rc;
>> > > > > > >
>> > > > > > >       rdev =3D en_info->rdev;
>> > > > > > > +     if (!rdev)
>> > > > > > > +             return;
>> > > > > > >       msix_ent =3D rdev->nqr->msix_entries;
>> > > > > > >       rcfw =3D &rdev->rcfw;
>> > > > > > >       if (!ent) {
>> > > > > > > @@ -2438,6 +2442,7 @@ static int bnxt_re_suspend(struct a=
uxiliary_device *adev, pm_message_t state)
>> > > > > > >       ibdev_info(&rdev->ibdev, "%s: L2 driver notified to=
 stop en_state 0x%lx",
>> > > > > > >                  __func__, en_dev->en_state);
>> > > > > > >       bnxt_re_remove_device(rdev, BNXT_RE_PRE_RECOVERY_RE=
MOVE, adev);
>> > > > > > > +     bnxt_re_update_en_info_rdev(NULL, en_info, adev);
>> > > > > > >       mutex_unlock(&bnxt_re_mutex);
>> > > > > > >
>> > > > > > >       return 0;
>> > > > > > > --
>> > > > > > > 2.5.5
>> > > > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > > --
>> > > > > Regards,
>> > > > > Kalesh AP
>> > > >
>> > > >
>> > >
>> > >
>> > > --
>> > > Regards,
>> > > Kalesh AP
>> >
>> >
>>
>>
>> --
>> Regards,
>> Kalesh AP
>
> Attachments:
> * smime.p7s

